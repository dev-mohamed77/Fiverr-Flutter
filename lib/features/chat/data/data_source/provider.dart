import 'package:fiverr/core/service/network_service/dio_service.dart';
import 'package:fiverr/features/chat/data/data_source/messages_remote_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final messagesRemoteDataSourceProvider =
    Provider<MessagesRemoteDataSource>((ref) {
  final dioService = ref.watch(dioServiceProvider);

  return MessagesRemoteDataSourceImp(netWorkService: dioService);
});
