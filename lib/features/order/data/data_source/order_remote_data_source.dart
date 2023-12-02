// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fiverr/core/service/network_service/network_service.dart';
import 'package:fiverr/features/order/data/model/order_model.dart';
import 'package:fiverr/features/order/data/model/orders_model.dart';
import 'package:fiverr/features/order/domain/entity/create_order_entity.dart';

abstract class OrderRemoteDataSource {
  Future<OrderModel> createOrder(CreateOrderEntity createOrder);

  Future<OrdersModel> getOrders({
    String? limit,
    String? page,
  });
  Future<OrdersModel> getOrdersBySellerId(
    String sellerId, {
    String? limit,
    String? page,
    String? status,
  });
  Future<OrdersModel> getOrdersByUserId(
    String userId, {
    String? limit,
    String? page,
    String? status,
  });
  Future<OrderModel> getOrdersById(String id);
  Future<OrderModel> updateStatusOrders(
    String id, {
    String? sellerStatus,
    String? userStatus,
  });
  Future<String> deleteOrders(String id);
}

class OrderRemoteDataSourceImp implements OrderRemoteDataSource {
  final NetWorkService netWorkService;
  OrderRemoteDataSourceImp({
    required this.netWorkService,
  });

  @override
  Future<OrderModel> createOrder(CreateOrderEntity createOrder) async {
    final response = await netWorkService.postData(
      "orders",
      data: {
        "seller": createOrder.seller,
        "gig": createOrder.gig,
        "deliveryTime": createOrder.deliveryTime,
        "payment": createOrder.payment,
        "description": createOrder.description,
        "subTotal": createOrder.subTotal,
        "serviceFee": createOrder.serviceFee,
      },
    );

    final data = response.data["result"];

    return OrderModel.fromMap(data);
  }

  @override
  Future<OrdersModel> getOrders({
    String? limit,
    String? page,
  }) async {
    final response = await netWorkService.getData(
      "orders",
      queryParams: {
        "limit": limit,
        "page": page,
      },
    );

    final data = response.data;

    return OrdersModel.fromMap(data);
  }

  @override
  Future<OrdersModel> getOrdersBySellerId(
    String sellerId, {
    String? limit,
    String? page,
    String? status,
  }) async {
    final response = await netWorkService.getData(
      "$sellerId/order-seller",
      queryParams: {
        "limit": limit,
        "page": page,
        "status": status,
      },
    );

    final data = response.data;

    return OrdersModel.fromMap(data);
  }

  @override
  Future<OrdersModel> getOrdersByUserId(
    String userId, {
    String? limit,
    String? page,
    String? status,
  }) async {
    final response = await netWorkService.getData(
      "$userId/order-user",
      queryParams: {
        "limit": limit,
        "page": page,
        "status": status,
      },
    );

    final data = response.data;

    return OrdersModel.fromMap(data);
  }

  @override
  Future<OrderModel> getOrdersById(String id) async {
    final response = await netWorkService.getData("orders/$id");

    final data = response.data["result"];

    return OrderModel.fromMap(data);
  }

  @override
  Future<OrderModel> updateStatusOrders(
    String id, {
    String? sellerStatus,
    String? userStatus,
  }) async {
    final response = await netWorkService.updateData(
      "orders/$id",
      data: sellerStatus != null && userStatus != null
          ? {
              "statusSeller": sellerStatus,
              "statusUser": userStatus,
            }
          : sellerStatus != null
              ? {
                  "statusSeller": sellerStatus,
                }
              : {
                  "statusUser": userStatus,
                },
    );

    final data = response.data["result"];

    return OrderModel.fromMap(data);
  }

  @override
  Future<String> deleteOrders(String id) async {
    final response = await netWorkService.getData("orders/$id");

    final data = response.data["result"];

    return data;
  }
}
