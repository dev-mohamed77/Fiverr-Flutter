import 'dart:async';

import 'package:fiverr/features/gigs/data/model/gig_model.dart';
import 'package:fiverr/features/gigs/domain/entity/gig_entity.dart';
import 'package:fiverr/features/gigs/domain/repository/privoder.dart';
import 'package:fiverr/features/gigs/domain/usecase/gig-images/add_image_of_th_gig.usecase.dart';
import 'package:fiverr/features/gigs/domain/usecase/gig-images/delete_image_of_the_gig.usecase.dart';
import 'package:fiverr/features/gigs/domain/usecase/gigs/create_gig.usecase.dart';
import 'package:fiverr/features/gigs/domain/usecase/gigs/delete_gig.usecase.dart';
import 'package:fiverr/features/gigs/domain/usecase/gigs/get_gigs_by_category_id_usecase.dart';
import 'package:fiverr/features/gigs/domain/usecase/gigs/get_gigs_by_seller_id.usecase.dart';
import 'package:fiverr/features/gigs/domain/usecase/gigs/get_gigs_by_subcategory_id_usecase.dart';
import 'package:fiverr/features/gigs/domain/usecase/gigs/update_gig.usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final createGigUseCaseProvider =
    StateNotifierProvider.autoDispose<CreateGigUseCase, AsyncValue<GigEntity?>>(
        (ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });

  final gigsRepo = ref.watch(gigsRepositoryProvider);

  return CreateGigUseCase(gigsRepo);
});

final getGigsBySubCategoryIdUseCaseProvider = StateNotifierProvider.autoDispose<
    GetGigsBySubCategoryIdUseCase, AsyncValue<List<GigEntity>?>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });

  final gigsRepo = ref.watch(gigsRepositoryProvider);

  return GetGigsBySubCategoryIdUseCase(gigsRepo, ref);
});

final getGigsByCategoryIdUseCaseProvider = StateNotifierProvider.autoDispose<
    GetGigsByCategoryIdUseCase, AsyncValue<List<GigEntity>?>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });

  final gigsRepo = ref.watch(gigsRepositoryProvider);

  return GetGigsByCategoryIdUseCase(gigsRepo);
});

final getGigsBySellerIdUseCaseProvider = StateNotifierProvider.autoDispose<
    GetGigsBySellerIdUseCase, AsyncValue<List<GigEntity>?>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });

  final gigsRepo = ref.watch(gigsRepositoryProvider);

  return GetGigsBySellerIdUseCase(gigsRepo);
});

final updateGigUseCaseProvider =
    StateNotifierProvider.autoDispose<UpdateGigUseCase, AsyncValue<GigEntity?>>(
        (ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });

  final gigsRepo = ref.watch(gigsRepositoryProvider);

  return UpdateGigUseCase(gigsRepo);
});

final deleteGigUseCaseProvider =
    StateNotifierProvider.autoDispose<DeleteGigUseCase, AsyncValue<String?>>(
        (ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });

  final gigsRepo = ref.watch(gigsRepositoryProvider);

  return DeleteGigUseCase(gigsRepo);
});

final addImageOfTheGigUsecaseProvider = StateNotifierProvider.autoDispose<
    AddImageOfTheGigUseCase, AsyncValue<GigImageModel?>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });

  final gigsRepo = ref.watch(gigImagesRepositoryProvider);

  return AddImageOfTheGigUseCase(gigsRepo);
});

final deleteImageOfTheGigUsecaseProvider = StateNotifierProvider.autoDispose<
    DeleteImageOfTheGigUseCase, AsyncValue<String?>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });

  final gigsRepo = ref.watch(gigImagesRepositoryProvider);

  return DeleteImageOfTheGigUseCase(gigsRepo);
});
