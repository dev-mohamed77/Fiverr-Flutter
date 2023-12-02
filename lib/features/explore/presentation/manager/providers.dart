import 'dart:async';

import 'package:fiverr/features/explore/domain/entity/category_entity.dart';
import 'package:fiverr/features/explore/domain/repository/provider.dart';
import 'package:fiverr/features/explore/domain/usecase/add_category_usecase.dart';
import 'package:fiverr/features/explore/domain/usecase/delete_category.dart';
import 'package:fiverr/features/explore/domain/usecase/gat_category_by_id_usecase.dart';
import 'package:fiverr/features/explore/domain/usecase/get_categories_usecase.dart';
import 'package:fiverr/features/explore/domain/usecase/update_category_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addCategoryUseCaseProvider = StateNotifierProvider.autoDispose<
    AddCategoryUseCase, AsyncValue<CategoryEntity?>>((ref) {
  final repo = ref.watch(categoryRepositoryProvider);
  return AddCategoryUseCase(repo);
});

final getCategoryByIDUseCaseProvider = StateNotifierProvider.autoDispose<
    GetCategoryByIDUseCase, AsyncValue<CategoryEntity?>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });

  final repo = ref.watch(categoryRepositoryProvider);
  return GetCategoryByIDUseCase(repo);
});

final getCategoriesUseCaseProvider = StateNotifierProvider.autoDispose<
    GetCategoriesUseCase, AsyncValue<List<CategoryEntity>?>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });

  final repo = ref.watch(categoryRepositoryProvider);
  return GetCategoriesUseCase(repo);
});

final updateCategoryUseCaseProvider = StateNotifierProvider.autoDispose<
    UpdateCategoryUseCase, AsyncValue<CategoryEntity?>>((ref) {
  final repo = ref.watch(categoryRepositoryProvider);
  return UpdateCategoryUseCase(repo);
});

final deleteCategoryUseCaseProvider = StateNotifierProvider.autoDispose<
    DeleteCategoryUseCase, AsyncValue<String?>>((ref) {
  final repo = ref.watch(categoryRepositoryProvider);
  return DeleteCategoryUseCase(repo);
});
