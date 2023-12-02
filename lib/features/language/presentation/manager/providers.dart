import 'dart:async';

import 'package:fiverr/features/language/domain/entity/language_entity.dart';
import 'package:fiverr/features/language/domain/repository/providers.dart';
import 'package:fiverr/features/language/domain/usecase/create_language_usecase.dart';
import 'package:fiverr/features/language/domain/usecase/delete_language_usecase.dart';
import 'package:fiverr/features/language/domain/usecase/get_languages_by_seller_id_usecase.dart';
import 'package:fiverr/features/language/domain/usecase/update_language_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final createLanguageUseCaseProvider = StateNotifierProvider.autoDispose<
    CreateLanguageUseCase, AsyncValue<LanguageEntity?>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });

  final repo = ref.watch(languageRepositoryProvider);
  return CreateLanguageUseCase(repo);
});

final getLanguageBySellerIdUseCaseProvider = StateNotifierProvider.autoDispose<
    GetLanguagesBySellerIdUseCase, AsyncValue<List<LanguageEntity>?>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });

  final repo = ref.watch(languageRepositoryProvider);
  return GetLanguagesBySellerIdUseCase(repo);
});

final updateLanguageUseCaseProvider = StateNotifierProvider.autoDispose<
    UpdateLanguageUseCase, AsyncValue<LanguageEntity?>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });

  final repo = ref.watch(languageRepositoryProvider);
  return UpdateLanguageUseCase(repo);
});

final deleteLanguageUseCaseProvider = StateNotifierProvider.autoDispose<
    DeleteLanguageUseCase, AsyncValue<String?>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });

  final repo = ref.watch(languageRepositoryProvider);
  return DeleteLanguageUseCase(repo);
});
