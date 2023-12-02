import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/core/service/web_socket/web_socket_manager.dart';
import 'package:fiverr/features/chat/data/model/messages_model.dart';
import 'package:fiverr/features/chat/domain/entity/message_entity.dart';
import 'package:fiverr/features/chat/domain/repository/messages_repository.dart';
import 'package:fiverr/features/chat/presentation/manager/select_conversation_provider.dart';
import 'package:fiverr/features/inbox/presentation/manager/providers.dart';

class GetMessagesByConversationIdUsecase
    extends StateNotifier<AsyncValue<List<MessageDataEntity>?>> {
  GetMessagesByConversationIdUsecase(this.repo, this.ref)
      : super(const AsyncValue.data(null)) {
    socket = ref.read(webSocketManagerProvider);
  }

  final limit = 15;
  int page = 1;
  bool _noItemMore = false;

  bool get noItemMore => _noItemMore;

  final MessagesRepository repo;
  final Ref ref;

  late WebSocketManager socket;

  Future<void> execute({
    required String conversationId,
  }) async {
    state = const AsyncValue.loading();

    page = 1;

    final result = await repo.getMessagesByConversationID(
      conversationId: conversationId,
      limit: limit.toString(),
      page: page.toString(),
    );

    result.when(success: (data) {
      _noItemMore = data.result.length < limit;
      state = AsyncValue.data(data.result);
      getMessagesFromSocket();
    }, failure: (errorHandle) {
      state = AsyncValue.error(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      );
    });
  }

  getMessagesFromSocket() {
    final items = state.hasValue ? state.value! : <MessageDataEntity>[];
    socket.channel.on(
      "getMessage",
      (data) {
        items.insert(0, MessageDataModel.fromMap(data));
        state = AsyncValue.data(items);
      },
    );
    // isScrollToBottom();
  }

  sendMessage({
    required String sellerId,
    required String sender,
    required String message,
    required TextEditingController textEditingController,
  }) async {
    final conversation = ref.watch(selectConversationProvider);
    final items = state.value ?? [];

    try {
      if (conversation == null && items.isEmpty) {
        // create conversation
        ref
            .read(createConversationUseCase.notifier)
            .execute(sellerID: sellerId);
      } else {
        // send message
        sendMessageSocket(
          model: SendMessageModel(
            conversation: conversation?.id ?? "",
            message: message,
            sender: sender,
            user: conversation?.user.id ?? "",
            seller: sellerId,
          ),
          userModel: UserInputModel(
              id: conversation!.user.id,
              name: conversation.user.name,
              email: conversation.user.email),
          sellerModel: SellerInputModel(
            id: conversation.seller.id,
            fullName: conversation.seller.fullName,
            displayName: conversation.seller.displayName,
            picture: conversation.seller.picture,
          ),
        );
        textEditingController.clear();
      }
      // isScrollToBottom();
    } catch (err) {
      state = AsyncValue.error(
          "There was an error sending the message $err", StackTrace.current);
    }
  }

  void sendMessageSocket({
    required SendMessageModel model,
    required UserInputModel userModel,
    required SellerInputModel sellerModel,
  }) {
    socket.channel.emit(
      "chatMessage",
      model.toMap(),
    );
    final items = state.value ?? [];

    final message = MessageDataModel(
      message: model.message,
      sender: model.sender,
      conversation: MessageConversationModel(id: model.conversation),
      seller: MessageSellerModel(
        id: sellerModel.id,
        fullName: sellerModel.fullName,
        displayName: sellerModel.displayName,
        picture: sellerModel.picture,
      ),
      user: MessageUserModel(
        id: userModel.id,
        name: userModel.name,
        email: userModel.email,
      ),
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: "",
    );
    items.insert(0, message);
    state = AsyncValue.data(items);
  }

  loadedMoreData() {
    if (!_noItemMore) {
      page++;

      _fetchMessages();
    }
  }

  void _fetchMessages() async {
    final conversation = ref.watch(selectConversationProvider);
    final result = await repo.getMessagesByConversationID(
      conversationId: conversation!.id,
      page: page.toString(),
      limit: limit.toString(),
    );

    result.when(success: (data) {
      _noItemMore = data.result.length < limit;
      state = AsyncValue.data([...state.value ?? [], ...data.result]);
      getMessagesFromSocket();
    }, failure: (errorHandle) {
      state = AsyncValue.error(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      );
    });
  }
}

class SendMessageModel {
  final String message;
  final String sender;
  final String conversation;
  final String user;
  final String seller;

  SendMessageModel({
    required this.message,
    required this.sender,
    required this.conversation,
    required this.user,
    required this.seller,
  });

  // create toMap

  Map<String, dynamic> toMap() {
    return {
      "message": message,
      "sender": sender,
      "conversation": conversation,
      "user": user,
      "seller": seller,
    };
  }
}

class UserInputModel {
  final String id;
  final String name;
  final String email;
  UserInputModel({
    required this.id,
    required this.name,
    required this.email,
  });
}

class SellerInputModel {
  final String id;
  final String fullName;
  final String displayName;
  final String picture;
  SellerInputModel({
    required this.id,
    required this.fullName,
    required this.displayName,
    required this.picture,
  });
}
