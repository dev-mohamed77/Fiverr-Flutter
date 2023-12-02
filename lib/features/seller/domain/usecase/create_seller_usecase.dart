import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/seller/domain/entity/seller_entity.dart';
import 'package:fiverr/features/seller/domain/repository/seller_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateSellerUseCase extends StateNotifier<AsyncValue<SellerEntity?>> {
  CreateSellerUseCase(this.repo) : super(const AsyncValue.data(null));

  final ISellerRepository repo;

  Future<void> execute({
    required String fullName,
    required String displayName,
    required String description,
    required String image,
    String? website,
  }) async {
    state = const AsyncValue.loading();

    final result = await repo.createSeller(
      fullName: fullName,
      displayName: displayName,
      description: description,
      image: image,
    );

    state = result.when(
      success: (data) {
        return AsyncValue.data(data);
      },
      failure: (errorHandle) {
        return AsyncValue.error(
          ErrorHandle.getErrorMessage(errorHandle),
          StackTrace.current,
        );
      },
    );
  }
}
