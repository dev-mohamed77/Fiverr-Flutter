import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/order/domain/repository/order_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeleteOrderUseCase extends StateNotifier<AsyncValue<String?>> {
  DeleteOrderUseCase(this.repo) : super(const AsyncValue.data(null));

  final IOrderRepository repo;

  Future<void> execute({
    required String id,
  }) async {
    state = const AsyncValue.loading();

    final result = await repo.deleteOrders(id);

    state = result.when(
      success: (data) => AsyncValue.data(data),
      failure: (errorHandle) => AsyncValue.error(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      ),
    );
  }
}
