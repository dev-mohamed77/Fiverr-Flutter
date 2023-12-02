import 'package:fiverr/core/service/network_service/dio_service.dart';
import 'package:fiverr/features/reviews/data/data_source/review_remote_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reviewRemoteDataSourceProvider = Provider<ReviewRemoteDataSource>((ref) {
  final dio = ref.watch(dioServiceProvider);
  return ReviewRemoteDataSourceImp(netWorkService: dio);
});
