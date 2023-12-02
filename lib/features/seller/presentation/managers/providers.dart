import 'dart:async';

import 'package:fiverr/features/seller/domain/entity/seller_entity.dart';
import 'package:fiverr/features/seller/domain/repository/providers.dart';
import 'package:fiverr/features/seller/domain/usecase/create_seller_usecase.dart';
import 'package:fiverr/features/seller/domain/usecase/delete_seller_usecase.dart';
import 'package:fiverr/features/seller/domain/usecase/get_seller_by_id_usecase.dart';
import 'package:fiverr/features/seller/domain/usecase/get_seller_by_logged_user_usecase.dart';
import 'package:fiverr/features/seller/domain/usecase/update_seller_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final createSellerUseCaseProvider = StateNotifierProvider.autoDispose<
    CreateSellerUseCase, AsyncValue<SellerEntity?>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });

  final repo = ref.watch(sellerRepositoryProvider);
  return CreateSellerUseCase(repo);
});

final getSellerByLoggedUserUseCaseProvider = StateNotifierProvider.autoDispose<
    GetSellerByLoggedUserUseCase, AsyncValue<SellerEntity?>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });
  final repo = ref.watch(sellerRepositoryProvider);
  return GetSellerByLoggedUserUseCase(repo);
});

final getSellerByIdUseCaseProvider = StateNotifierProvider.autoDispose<
    GetSellerByIdUseCase, AsyncValue<SellerEntity?>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });
  final repo = ref.watch(sellerRepositoryProvider);
  return GetSellerByIdUseCase(repo);
});

final updateSellerUseCaseProvider = StateNotifierProvider.autoDispose<
    UpdateSellerUseCase, AsyncValue<SellerEntity?>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });

  final repo = ref.watch(sellerRepositoryProvider);
  return UpdateSellerUseCase(repo);
});

final deleteSellerUseCaseProvider =
    StateNotifierProvider.autoDispose<DeleteSellerUseCase, AsyncValue<String?>>(
        (ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });

  final repo = ref.watch(sellerRepositoryProvider);
  return DeleteSellerUseCase(repo);
});
