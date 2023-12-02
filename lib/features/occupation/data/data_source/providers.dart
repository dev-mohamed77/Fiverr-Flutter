import 'package:fiverr/core/service/network_service/dio_service.dart';
import 'package:fiverr/features/occupation/data/data_source/occupation_remote_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final occupationRemoteDataSourceProvider =
    Provider<OccupationRemoteDataSource>((ref) {
  final dioService = ref.watch(dioServiceProvider);
  return OccupationRemoteDataSourceImp(netWorkService: dioService);
});
