import 'package:fiverr/features/my_list/data/data_source/provider.dart';
import 'package:fiverr/features/my_list/data/repository/my_list_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final myListRepositoryProvider = Provider((ref) {
  final myListRemoteDataSource = ref.watch(myListRemoteDataSourceProvider);
  return MyListRepositoryImp(remoteDataSource: myListRemoteDataSource);
});
