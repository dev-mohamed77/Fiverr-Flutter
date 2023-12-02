import 'dart:async';

import 'package:fiverr/features/reviews/domain/entity/review_entity.dart';
import 'package:fiverr/features/reviews/domain/repository/providers.dart';
import 'package:fiverr/features/reviews/domain/usecase/create_review_usecase.dart';
import 'package:fiverr/features/reviews/domain/usecase/get_reviews_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final createReviewsUseCaseProvider = StateNotifierProvider.autoDispose<
    CreateReviewsUseCase, AsyncValue<ReviewDataEntity?>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 20), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });
  final repo = ref.watch(reviewsRepositoryProvider);
  return CreateReviewsUseCase(repo);
});

final getReviewsUseCaseProvider = StateNotifierProvider.autoDispose<
    GetReviewsUseCase, AsyncValue<ReviewEntity?>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 20), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });
  final repo = ref.watch(reviewsRepositoryProvider);
  return GetReviewsUseCase(repo);
});
