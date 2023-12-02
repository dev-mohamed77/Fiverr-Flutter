import 'dart:async';

import 'package:fiverr/features/chat/domain/entity/message_entity.dart';
import 'package:fiverr/features/chat/domain/repository/provider.dart';
import 'package:fiverr/features/chat/domain/usecase/delete_message.dart';
import 'package:fiverr/features/chat/domain/usecase/get_messages_conversation_id_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getMessagesByConversationIDUseCaseProvider =
    StateNotifierProvider.autoDispose<GetMessagesByConversationIdUsecase,
        AsyncValue<List<MessageDataEntity>?>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });

  final repo = ref.watch(messagesRepositoryProvider);
  return GetMessagesByConversationIdUsecase(repo, ref);
});

final deleteMessageUseCaseProvider = StateNotifierProvider.autoDispose<
    DeleteMessagesUseCase, AsyncValue<String?>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });

  final repo = ref.watch(messagesRepositoryProvider);
  return DeleteMessagesUseCase(repo);
});
