import 'dart:async';

import 'package:fiverr/features/occupation/domain/entity/occupation_entity.dart';
import 'package:fiverr/features/occupation/domain/repository/providers.dart';
import 'package:fiverr/features/occupation/domain/usecase/create_occupation_usecase.dart';
import 'package:fiverr/features/occupation/domain/usecase/delete_occupation_usecase.dart';
import 'package:fiverr/features/occupation/domain/usecase/get_occupation_by_seller_id_usecase.dart';
import 'package:fiverr/features/occupation/domain/usecase/update_occupation_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final createOccupationUseCaseProvider = StateNotifierProvider.autoDispose<
    CreateOccupationUseCase, AsyncValue<OccupationEntity?>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });

  final repo = ref.watch(occupationRepositoryProvider);
  return CreateOccupationUseCase(repo);
});

final getOccupationBySellerIdUseCaseProvider =
    StateNotifierProvider.autoDispose<GetOccupationsBySellerIdUseCase,
        AsyncValue<List<OccupationEntity>?>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });

  final repo = ref.watch(occupationRepositoryProvider);
  return GetOccupationsBySellerIdUseCase(repo);
});

final updateOccupationUseCaseProvider = StateNotifierProvider.autoDispose<
    UpdateOccupationUseCase, AsyncValue<OccupationEntity?>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });

  final repo = ref.watch(occupationRepositoryProvider);
  return UpdateOccupationUseCase(repo);
});

final deleteOccupationUseCaseProvider = StateNotifierProvider.autoDispose<
    DeleteOccupationUseCase, AsyncValue<String?>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });

  final repo = ref.watch(occupationRepositoryProvider);
  return DeleteOccupationUseCase(repo);
});
