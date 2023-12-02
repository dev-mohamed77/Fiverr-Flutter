import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/order/domain/entity/order_entity.dart';
import 'package:fiverr/features/order/domain/entity/orders_entity.dart';
import 'package:fiverr/features/order/domain/repository/order_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetOrdersBySellerIdUseCase
    extends StateNotifier<AsyncValue<OrdersEntity>> {
  GetOrdersBySellerIdUseCase(this.repo) : super(const AsyncValue.loading());

  final IOrderRepository repo;

  Future<void> execute(
    String sellerId, {
    String? limit,
    String? page,
    String? status,
  }) async {
    state = const AsyncValue.loading();

    final result = await repo.getOrdersBySellerId(
      sellerId,
      limit: "70",
      page: page,
      status: status,
    );

    state = result.when(
      success: (data) => AsyncValue.data(data),
      failure: (errorHandle) => AsyncValue.error(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      ),
    );
  }

  removeOrder(OrderEntity entity) {
    final items = state.value?.result ?? [];

    state = const AsyncValue.loading();

    items.removeWhere(
      (element) => element.id == entity.id,
    );

    state =
        AsyncValue.data(OrdersEntity(length: items.length - 1, result: items));
  }
}
