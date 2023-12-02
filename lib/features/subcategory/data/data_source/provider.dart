import 'package:fiverr/core/service/network_service/dio_service.dart';
import 'package:fiverr/features/subcategory/data/data_source/subcategory_remote_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final subCategoryRemoteDataSourceProvider = Provider((ref) {
  final dioService = ref.watch(dioServiceProvider);

  return SubCategoryRemoteDataSourceImp(netWorkService: dioService);
});
