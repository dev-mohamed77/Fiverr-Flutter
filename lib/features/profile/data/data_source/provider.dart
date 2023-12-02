import 'package:fiverr/core/service/network_service/dio_service.dart';
import 'package:fiverr/features/profile/data/data_source/user_remote_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRemoteDataSourceProvider = Provider((ref) {
  final dioService = ref.watch(dioServiceProvider);

  return UserRemoteDataSourceImp(networkService: dioService);
});
