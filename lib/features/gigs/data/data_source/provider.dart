import 'package:fiverr/core/service/network_service/dio_service.dart';
import 'package:fiverr/features/gigs/data/data_source/gig_images_remote_data_source.dart';
import 'package:fiverr/features/gigs/data/data_source/gigs_remote_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gigsRemoteDataSourceProvider = Provider<GigsRemoteDataSource>((ref) {
  final dioService = ref.watch(dioServiceProvider);

  return GigsRemoteDataSourceImp(netWorkService: dioService);
});

final gigImagesRemoteDataSourceProvider =
    Provider<GigImagesRemoteDataSource>((ref) {
  final dioService = ref.watch(dioServiceProvider);

  return GigImagesRemoteDataSourceImp(netWorkService: dioService);
});
