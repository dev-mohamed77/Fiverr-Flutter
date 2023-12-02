import 'dart:io';

import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/gigs/domain/entity/gig_entity.dart';
import 'package:fiverr/features/gigs/domain/repository/gigs_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateGigUseCase extends StateNotifier<AsyncValue<GigEntity?>> {
  CreateGigUseCase(this.repo) : super(const AsyncValue.data(null));
  final GigsRepository repo;

  Future<void> execute({
    required String title,
    required String description,
    required String price,
    required String categoryId,
    required String subCategoryId,
    required File coverImage,
    required List<File> images,
    required String deliveryTime,
  }) async {
    state = const AsyncValue.loading();

    final result = await repo.createGig(
      title: title,
      description: description,
      price: price,
      categoryId: categoryId,
      subCategoryId: subCategoryId,
      coverImage: coverImage,
      images: images,
      deliveryTime: deliveryTime,
    );

    state = result.when(
      success: (data) => AsyncValue.data(data),
      failure: (errorHandle) => AsyncValue.error(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      ),
    );
  }
}
