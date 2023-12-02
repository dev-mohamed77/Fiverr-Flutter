import 'package:fiverr/core/providers/user/user_provider.dart';
import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/order/domain/entity/order_entity.dart';
import 'package:fiverr/features/order/domain/entity/orders_entity.dart';
import 'package:fiverr/features/order/domain/repository/order_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetOrdersByUserIdUseCase extends StateNotifier<AsyncValue<OrdersEntity>> {
  GetOrdersByUserIdUseCase(this.repo, this.ref)
      : super(const AsyncValue.loading()) {
    final user = ref.watch(userProvider);

    if (user != null) {
      execute(user.id);
    }
  }

  final IOrderRepository repo;
  final Ref ref;

  Future<void> execute(
    String userId, {
    String? limit,
    String? page,
    String? status,
  }) async {
    state = const AsyncValue.loading();

    final result = await repo.getOrdersByUserId(
      userId,
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
