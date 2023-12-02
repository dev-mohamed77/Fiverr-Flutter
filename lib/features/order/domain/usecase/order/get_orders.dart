import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/order/domain/entity/orders_entity.dart';
import 'package:fiverr/features/order/domain/repository/order_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetOrdersUseCase extends StateNotifier<AsyncValue<OrdersEntity>> {
  GetOrdersUseCase(this.repo) : super(const AsyncValue.loading());

  final IOrderRepository repo;

  Future<void> execute(
    String sellerId, {
    String? limit,
    String? page,
  }) async {
    state = const AsyncValue.loading();

    final result = await repo.getOrders(limit: limit, page: page);

    state = result.when(
      success: (data) => AsyncValue.data(data),
      failure: (errorHandle) => AsyncValue.error(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      ),
    );
  }
}
