import 'package:fiverr/core/service/network_service/dio_service.dart';
import 'package:fiverr/features/explore/data/data_source/category_remote_datas_ource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryRemoteDataSourceProvider = Provider((ref) {
  final dioService = ref.watch(dioServiceProvider);

  return CategoryRemoteDataSourceImp(netWorkService: dioService);
});
