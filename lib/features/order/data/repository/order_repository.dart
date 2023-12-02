// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/core/service/network_service/api/api_result.dart';
import 'package:fiverr/features/order/data/data_source/order_remote_data_source.dart';
import 'package:fiverr/features/order/domain/entity/create_order_entity.dart';
import 'package:fiverr/features/order/domain/entity/order_entity.dart';
import 'package:fiverr/features/order/domain/entity/orders_entity.dart';
import 'package:fiverr/features/order/domain/repository/order_repository.dart';

class OrderRepositoryImp implements IOrderRepository {
  final OrderRemoteDataSource orderDataSource;
  const OrderRepositoryImp({required this.orderDataSource});

  @override
  Future<ApiResult<OrderEntity>> createOrder(
      CreateOrderEntity createOrder) async {
    try {
      final result = await orderDataSource.createOrder(createOrder);

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<OrdersEntity>> getOrders({
    String? limit,
    String? page,
  }) async {
    try {
      final result = await orderDataSource.getOrders(limit: limit, page: page);

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<OrderEntity>> getOrdersById(String id) async {
    try {
      final result = await orderDataSource.getOrdersById(id);

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<OrdersEntity>> getOrdersBySellerId(
    String sellerId, {
    String? limit,
    String? page,
    String? status,
  }) async {
    try {
      final result = await orderDataSource.getOrdersBySellerId(
        sellerId,
        limit: limit,
        page: page,
        status: status,
      );

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<OrdersEntity>> getOrdersByUserId(
    String userId, {
    String? limit,
    String? page,
    String? status,
  }) async {
    try {
      final result = await orderDataSource.getOrdersByUserId(
        userId,
        limit: limit,
        page: page,
        status: status,
      );

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<OrderEntity>> updateStatusOrders(
    String id, {
    String? sellerStatus,
    String? userStatus,
  }) async {
    try {
      final result = await orderDataSource.updateStatusOrders(
        id,
        sellerStatus: sellerStatus,
        userStatus: userStatus,
      );

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<String>> deleteOrders(String id) async {
    try {
      final result = await orderDataSource.deleteOrders(id);

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }
}
