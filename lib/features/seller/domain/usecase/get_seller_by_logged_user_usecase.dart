import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/seller/domain/entity/seller_entity.dart';
import 'package:fiverr/features/seller/domain/repository/seller_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetSellerByLoggedUserUseCase
    extends StateNotifier<AsyncValue<SellerEntity?>> {
  GetSellerByLoggedUserUseCase(this.repo) : super(const AsyncValue.data(null)) {
    execute();
  }

  final ISellerRepository repo;

  Future<void> execute() async {
    state = const AsyncValue.loading();

    final result = await repo.getSellerByLoggedUser();

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
