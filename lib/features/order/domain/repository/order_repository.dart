import 'package:fiverr/core/service/network_service/api/api_result.dart';
import 'package:fiverr/features/order/domain/entity/create_order_entity.dart';
import 'package:fiverr/features/order/domain/entity/order_entity.dart';
import 'package:fiverr/features/order/domain/entity/orders_entity.dart';

abstract class IOrderRepository {
  Future<ApiResult<OrderEntity>> createOrder(CreateOrderEntity createOrder);

  Future<ApiResult<OrdersEntity>> getOrders({
    String? limit,
    String? page,
  });
  Future<ApiResult<OrdersEntity>> getOrdersBySellerId(
    String sellerId, {
    String? limit,
    String? page,
    String? status,
  });
  Future<ApiResult<OrdersEntity>> getOrdersByUserId(
    String userId, {
    String? limit,
    String? page,
    String? status,
  });
  Future<ApiResult<OrderEntity>> getOrdersById(String id);
  Future<ApiResult<OrderEntity>> updateStatusOrders(
    String id, {
    String? sellerStatus,
    String? userStatus,
  });
  Future<ApiResult<String>> deleteOrders(String id);
}
