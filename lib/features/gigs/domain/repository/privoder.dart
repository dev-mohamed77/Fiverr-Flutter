import 'package:fiverr/features/gigs/data/data_source/provider.dart';
import 'package:fiverr/features/gigs/data/repository/gig_images_repository.dart';
import 'package:fiverr/features/gigs/data/repository/gigs_repository.dart';
import 'package:fiverr/features/gigs/domain/repository/gig_images_repository.dart';
import 'package:fiverr/features/gigs/domain/repository/gigs_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gigsRepositoryProvider = Provider<GigsRepository>((ref) {
  final gigsRemoteDataSource = ref.watch(gigsRemoteDataSourceProvider);
  return GigsRepositoryImp(remoteDataSource: gigsRemoteDataSource);
});

final gigImagesRepositoryProvider = Provider<GigImagesRepository>((ref) {
  final gigImagesRemoteDataSource =
      ref.watch(gigImagesRemoteDataSourceProvider);
  return GigImagesRepositoryImp(remoteDataSource: gigImagesRemoteDataSource);
});
