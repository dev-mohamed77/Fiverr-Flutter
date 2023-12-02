import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/seller/domain/entity/seller_entity.dart';
import 'package:fiverr/features/seller/domain/repository/seller_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateSellerUseCase extends StateNotifier<AsyncValue<SellerEntity?>> {
  UpdateSellerUseCase(this.repo) : super(const AsyncValue.data(null));

  final ISellerRepository repo;

  Future<void> execute(
    String id, {
    String? fullName,
    String? displayName,
    String? description,
    String? image,
    String? website,
  }) async {
    state = const AsyncValue.loading();

    final result = await repo.updateSeller(
      id,
      fullName: fullName,
      displayName: displayName,
      description: description,
      image: image,
      website: website,
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
