import 'package:fiverr/core/service/network_service/dio_service.dart';
import 'package:fiverr/features/gig_details/data/data_source/gig_details_local_data_source.dart';
import 'package:fiverr/features/gig_details/data/data_source/gig_details_remote_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gigDetailsRemoteDataSourceProvider =
    Provider<GigDetailsRemoteDataSource>((ref) {
  final dioService = ref.watch(dioServiceProvider);

  return GigDetailsRemoteDataSourceImp(netWorkService: dioService);
});

final gigDetailsLocalDataSourceProvider =
    Provider<GigDetailsLocalDataSource>((ref) {
  return GigDetailsLocalDataSourceImp();
});
