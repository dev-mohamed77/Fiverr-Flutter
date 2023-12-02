import 'package:fiverr/features/reviews/data/data_source/providers.dart';
import 'package:fiverr/features/reviews/data/repository/reviews_repository.dart';
import 'package:fiverr/features/reviews/domain/repository/reviews_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reviewsRepositoryProvider = Provider<IReviewsRepository>((ref) {
  final reviewDataSource = ref.watch(reviewRemoteDataSourceProvider);
  return ReviewsRepositoryImp(dataSource: reviewDataSource);
});
