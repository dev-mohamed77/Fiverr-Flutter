import 'package:fiverr/features/subcategory/data/data_source/provider.dart';
import 'package:fiverr/features/subcategory/data/repository/subcategory_repository.dart';
import 'package:fiverr/features/subcategory/domain/repository/subcategory_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final subCategoryRepositoryProvider = Provider<SubCategoryRepository>((ref) {
  final remoteDataSource = ref.watch(subCategoryRemoteDataSourceProvider);

  return SubCategoryRepositoryImp(remoteDataSource: remoteDataSource);
});
