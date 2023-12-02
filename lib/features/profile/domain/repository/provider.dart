import 'package:fiverr/features/profile/data/data_source/provider.dart';
import 'package:fiverr/features/profile/data/repository/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRepositoryProvider = Provider((ref) {
  final dataSource = ref.watch(userRemoteDataSourceProvider);

  return UserRepositoryImp(remoteDataSource: dataSource);
});
