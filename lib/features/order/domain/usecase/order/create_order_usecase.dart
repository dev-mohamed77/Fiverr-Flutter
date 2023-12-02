import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/order/domain/entity/create_order_entity.dart';
import 'package:fiverr/features/order/domain/entity/order_entity.dart';
import 'package:fiverr/features/order/domain/repository/order_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateOrderUseCase extends StateNotifier<AsyncValue<OrderEntity?>> {
  CreateOrderUseCase(this.repo) : super(const AsyncValue.data(null));

  final IOrderRepository repo;

  Future<void> execute(CreateOrderEntity createOrder) async {
    state = const AsyncValue.loading();

    final result = await repo.createOrder(createOrder);

    state = result.when(
      success: (data) => AsyncValue.data(data),
      failure: (errorHandle) => AsyncValue.error(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      ),
    );
  }
}
