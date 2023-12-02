import 'package:fiverr/features/chat/data/data_source/provider.dart';
import 'package:fiverr/features/chat/data/repository/messages_repository.dart';
import 'package:fiverr/features/chat/domain/repository/messages_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final messagesRepositoryProvider = Provider<MessagesRepository>((ref) {
  final remoteDataSource = ref.watch(messagesRemoteDataSourceProvider);

  return MessagesRepositoryImp(remoteDataSource: remoteDataSource);
});
