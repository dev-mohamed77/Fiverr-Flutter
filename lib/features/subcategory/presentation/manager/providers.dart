import 'dart:async';

import 'package:fiverr/features/subcategory/domain/entity/sub_category_entity.dart';
import 'package:fiverr/features/subcategory/domain/repository/provider.dart';
import 'package:fiverr/features/subcategory/domain/usecase/add_subcategory_usecase.dart';
import 'package:fiverr/features/subcategory/domain/usecase/delete_subcategory.dart';
import 'package:fiverr/features/subcategory/domain/usecase/gat_subcategory_by_id_usecase.dart';
import 'package:fiverr/features/subcategory/domain/usecase/get_subcategories_by_category_id_usecase.dart';
import 'package:fiverr/features/subcategory/domain/usecase/get_subcategories_usecase.dart';
import 'package:fiverr/features/subcategory/domain/usecase/update_subcategory_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addSubCategoryUseCaseProvider = StateNotifierProvider.autoDispose<
    AddSubCategoryUseCase, AsyncValue<SubCategoryEntity?>>((ref) {
  final repo = ref.watch(subCategoryRepositoryProvider);
  return AddSubCategoryUseCase(repo);
});

final getSubCategoryByIDUseCaseProvider = StateNotifierProvider.autoDispose<
    GetSubCategoryByIDUseCase, AsyncValue<SubCategoryEntity?>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });
  final repo = ref.watch(subCategoryRepositoryProvider);
  return GetSubCategoryByIDUseCase(repo);
});

final getSubCategoriesByCategoryIDUseCaseProvider =
    StateNotifierProvider.autoDispose<GetSubCategoriesByCategoryIDUseCase,
        AsyncValue<List<SubCategoryEntity>?>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });

  final repo = ref.watch(subCategoryRepositoryProvider);
  return GetSubCategoriesByCategoryIDUseCase(repo, ref);
});

final getSubCategoriesUseCaseProvider = StateNotifierProvider.autoDispose<
    GetSubCategoriesUseCase, AsyncValue<List<SubCategoryEntity>?>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });
  final repo = ref.watch(subCategoryRepositoryProvider);
  return GetSubCategoriesUseCase(repo);
});

final updateSubCategoryUseCaseProvider = StateNotifierProvider.autoDispose<
    UpdateSubCategoryUseCase, AsyncValue<SubCategoryEntity?>>((ref) {
  final repo = ref.watch(subCategoryRepositoryProvider);
  return UpdateSubCategoryUseCase(repo);
});

final deleteSubCategoryUseCaseProvider = StateNotifierProvider.autoDispose<
    DeleteSubCategoryUseCase, AsyncValue<String?>>((ref) {
  final repo = ref.watch(subCategoryRepositoryProvider);
  return DeleteSubCategoryUseCase(repo);
});
