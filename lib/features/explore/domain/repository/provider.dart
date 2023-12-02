import 'package:fiverr/features/explore/data/data_source/category/provider.dart';
import 'package:fiverr/features/explore/data/repository/category_repository.dart';
import 'package:fiverr/features/explore/domain/repository/category_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  final remoteDataSource = ref.watch(categoryRemoteDataSourceProvider);

  return CategoryRepositoryImp(remoteDataSource: remoteDataSource);
});
