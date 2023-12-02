import 'package:fiverr/features/inbox/data/data_source/providers.dart';
import 'package:fiverr/features/inbox/data/repository/conversation_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final conversationRepositoryProvider = Provider((ref) {
  final remoteDataSource = ref.watch(conversationRemoteDataSourceProvider);
  return ConversationRepositoryImp(remoteDataSource: remoteDataSource);
});
