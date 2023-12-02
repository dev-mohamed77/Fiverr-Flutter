import 'dart:async';

import 'package:fiverr/features/inbox/domain/entity/conversation_data_entity.dart';
import 'package:fiverr/features/inbox/domain/repository/providers.dart';
import 'package:fiverr/features/inbox/domain/usecase/create_conversation_usecase.dart';
import 'package:fiverr/features/inbox/domain/usecase/get_conversation_by_user_id_and_seller_id_usecase.dart';
import 'package:fiverr/features/inbox/domain/usecase/get_conversations_by_seller_id_usecase.dart';
import 'package:fiverr/features/inbox/domain/usecase/get_conversations_by_user_id_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final createConversationUseCase = StateNotifierProvider<
    CreateConversationUseCase, AsyncValue<ConversationDataEntity?>>((ref) {
  final repo = ref.watch(conversationRepositoryProvider);

  return CreateConversationUseCase(repo);
});

final getConversationByUserIdAndSellerIdUseCase =
    StateNotifierProvider.autoDispose<GetConversationByUserIdAndSellerIdUseCase,
        AsyncValue<ConversationDataEntity?>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });

  final repo = ref.watch(conversationRepositoryProvider);

  return GetConversationByUserIdAndSellerIdUseCase(repo);
});

final getConversationsBySellerIdUseCase = StateNotifierProvider.autoDispose<
    GetConversationsBySellerIdUseCase,
    AsyncValue<List<ConversationDataEntity>>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });

  final repo = ref.watch(conversationRepositoryProvider);

  return GetConversationsBySellerIdUseCase(repo);
});

final getConversationsByUserIdUseCase = StateNotifierProvider.autoDispose<
    GetConversationsByUserIdUseCase,
    AsyncValue<List<ConversationDataEntity>>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });

  final repo = ref.watch(conversationRepositoryProvider);

  return GetConversationsByUserIdUseCase(repo);
});
