import 'package:fiverr/core/manager/dialog/dialog_custom.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/chat/domain/usecase/get_messages_conversation_id_usecase.dart';
import 'package:fiverr/features/chat/presentation/manager/join_room_socket_provider.dart';
import 'package:fiverr/features/chat/presentation/manager/providers.dart';
import 'package:fiverr/features/chat/presentation/manager/select_conversation_provider.dart';
import 'package:fiverr/features/chat/presentation/pages/widgets/chat_text_field_and_button_section.dart';
import 'package:fiverr/features/chat/presentation/pages/widgets/messages_list_section.dart';
import 'package:fiverr/features/inbox/presentation/manager/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatBody extends ConsumerStatefulWidget {
  const ChatBody({
    super.key,
    required this.sellerId,
    required this.sender,
  });
  final String sellerId;
  final String sender;

  @override
  ConsumerState<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends ConsumerState<ChatBody> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    // join room
    textEditingController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      init();
    });
    super.initState();
  }

  void init() {
    final conversation = ref.watch(selectConversationProvider);

    if (conversation != null) {
      ref.watch(joinRoomSocketProvider.call(JoinRoomModel(
        userId: conversation.user.id,
        sellerId: conversation.seller.id,
      )));
    }
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _listenGetConversationByUserIdAndSellerId();
    _listenCreateConversation();

    return WillPopScope(
      onWillPop: () {
        ref.read(selectConversationProvider.notifier).update((state) => null);
        return Future.value(true);
      },
      child: Column(
        children: [
          const Expanded(
            child: MessagesListSection(),
          ),
          ChatTextFieldAndButtonSection(
            sellerId: widget.sellerId,
            sender: widget.sender,
            textEditingController: textEditingController,
          ),
        ],
      ),
    );
  }

  _listenGetConversationByUserIdAndSellerId() {
    ref.listen(
      getConversationByUserIdAndSellerIdUseCase,
      (previous, next) {
        next.maybeWhen(
          orElse: () {},
          data: (data) {
            if (data != null) {
              ref.watch(joinRoomSocketProvider.call(JoinRoomModel(
                userId: data.user.id,
                sellerId: data.seller.id,
              )));

              ref
                  .read(selectConversationProvider.notifier)
                  .update((state) => data);
            }
          },
          error: (error, stackTrace) {
            DialogCustom.showToast(
              message: error.toString(),
              color: AppColor.redColor,
            );
          },
        );
      },
    );
  }

  _listenCreateConversation() {
    ref.listen(
      createConversationUseCase,
      (previous, next) {
        next.maybeWhen(
          orElse: () {},
          data: (data) {
            ref
                .read(getMessagesByConversationIDUseCaseProvider.notifier)
                // send message
                .sendMessageSocket(
                  model: SendMessageModel(
                    conversation: data!.id,
                    message: textEditingController.text,
                    sender: widget.sender,
                    user: data.user.id,
                    seller: data.seller.id,
                  ),
                  userModel: UserInputModel(
                      id: data.user.id,
                      name: data.user.name,
                      email: data.user.email),
                  sellerModel: SellerInputModel(
                    id: data.seller.id,
                    fullName: data.seller.fullName,
                    displayName: data.seller.displayName,
                    picture: data.seller.picture,
                  ),
                );

            // update selectConversationProvider

            ref
                .read(selectConversationProvider.notifier)
                .update((state) => data);
            textEditingController.clear();
          },
          error: (error, stackTrace) {
            DialogCustom.showToast(
              message: error.toString(),
              color: AppColor.redColor,
            );
          },
        );
      },
    );
  }
}
