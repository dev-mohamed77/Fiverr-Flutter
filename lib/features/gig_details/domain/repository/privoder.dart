import 'package:fiverr/features/gig_details/data/data_source/providers.dart';
import 'package:fiverr/features/gig_details/data/repository/gig_details_repository.dart';
import 'package:fiverr/features/gig_details/domain/repository/gig_details_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gigDetailsRepositoryProvider = Provider<IGigDetailsRepository>((ref) {
  final remoteDataSource = ref.watch(gigDetailsRemoteDataSourceProvider);
  final localDataSource = ref.watch(gigDetailsLocalDataSourceProvider);
  return GigDetailsRepositoryImp(
    localDataSource: localDataSource,
    remoteDataSource: remoteDataSource,
  );
});
