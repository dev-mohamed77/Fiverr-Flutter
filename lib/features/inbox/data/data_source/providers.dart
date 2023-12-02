import 'package:fiverr/core/service/network_service/dio_service.dart';
import 'package:fiverr/features/inbox/data/data_source/conversation_remote_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final conversationRemoteDataSourceProvider = Provider((ref) {
  final dioService = ref.watch(dioServiceProvider);
  return ConversationRemoteDataSourceImp(netWorkService: dioService);
});
