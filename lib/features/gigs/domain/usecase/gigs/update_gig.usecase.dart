import 'dart:io';

import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/gigs/domain/entity/gig_entity.dart';
import 'package:fiverr/features/gigs/domain/repository/gigs_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateGigUseCase extends StateNotifier<AsyncValue<GigEntity?>> {
  UpdateGigUseCase(this.repo) : super(const AsyncValue.data(null));
  final GigsRepository repo;

  Future<void> execute(
    String gigId, {
    String? title,
    String? description,
    String? price,
    String? categoryId,
    String? subCategoryId,
    File? coverImage,
    String? deliveryTime,
  }) async {
    state = const AsyncValue.loading();

    final result = await repo.updateGigById(
      gigId,
      title: title,
      price: price,
      description: description,
      deliveryTime: deliveryTime,
      categoryId: categoryId,
      coverImage: coverImage,
      subCategoryId: subCategoryId,
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
