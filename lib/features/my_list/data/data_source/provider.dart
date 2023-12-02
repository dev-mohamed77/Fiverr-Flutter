import 'package:fiverr/core/service/network_service/dio_service.dart';
import 'package:fiverr/features/my_list/data/data_source/my_list_remote_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final myListRemoteDataSourceProvider = Provider((ref) {
  final dioService = ref.watch(dioServiceProvider);
  return MyListRemoteDataSourceImp(networkService: dioService);
});
