import 'package:fiverr/features/occupation/data/data_source/providers.dart';
import 'package:fiverr/features/occupation/data/repository/occupation_repository.dart';
import 'package:fiverr/features/occupation/domain/repository/occupation_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final occupationRepositoryProvider = Provider<IOccupationRepository>((ref) {
  final remoteDataSource = ref.watch(occupationRemoteDataSourceProvider);

  return OccupationRepositoryImp(remoteDataSource: remoteDataSource);
});
