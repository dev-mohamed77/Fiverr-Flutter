import 'dart:async';

import 'package:fiverr/features/order/domain/entity/order_entity.dart';
import 'package:fiverr/features/order/domain/entity/orders_entity.dart';
import 'package:fiverr/features/order/domain/repository/providers.dart';
import 'package:fiverr/features/order/domain/usecase/order/create_order_usecase.dart';
import 'package:fiverr/features/order/domain/usecase/order/delete_order_usecase.dart';
import 'package:fiverr/features/order/domain/usecase/order/get_order_by_id_usecase.dart';
import 'package:fiverr/features/order/domain/usecase/order/get_orders.dart';
import 'package:fiverr/features/order/domain/usecase/order/get_orders_by_seller_id_usecase.dart';
import 'package:fiverr/features/order/domain/usecase/order/get_orders_by_user_id_usecase.dart';
import 'package:fiverr/features/order/domain/usecase/order/update_order_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final createOrderUseCaseProvider = StateNotifierProvider.autoDispose<
    CreateOrderUseCase, AsyncValue<OrderEntity?>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });
  final repository = ref.watch(orderRepositoryProvider);
  return CreateOrderUseCase(repository);
});

final getOrdersUseCaseProvider = StateNotifierProvider.autoDispose<
    GetOrdersUseCase, AsyncValue<OrdersEntity>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });
  final repository = ref.watch(orderRepositoryProvider);
  return GetOrdersUseCase(repository);
});

final getOrderBySellerIdUseCaseProvider = StateNotifierProvider.autoDispose<
    GetOrdersBySellerIdUseCase, AsyncValue<OrdersEntity>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });
  final repository = ref.watch(orderRepositoryProvider);
  return GetOrdersBySellerIdUseCase(repository);
});

final getOrderByUserIdUseCaseProvider = StateNotifierProvider.autoDispose<
    GetOrdersByUserIdUseCase, AsyncValue<OrdersEntity>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });
  final repository = ref.watch(orderRepositoryProvider);
  return GetOrdersByUserIdUseCase(repository, ref);
});

final getOrderByIdUseCaseProvider = StateNotifierProvider.autoDispose<
    GetOrderByIdUseCase, AsyncValue<OrderEntity>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });
  final repository = ref.watch(orderRepositoryProvider);
  return GetOrderByIdUseCase(repository);
});

final updateStatusOrderUseCaseProvider = StateNotifierProvider.autoDispose<
    UpdateStatusOrderUseCase, AsyncValue<OrderEntity?>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });
  final repository = ref.watch(orderRepositoryProvider);
  return UpdateStatusOrderUseCase(repository);
});

final deleteOrderUseCaseProvider =
    StateNotifierProvider.autoDispose<DeleteOrderUseCase, AsyncValue<String?>>(
        (ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });
  final repository = ref.watch(orderRepositoryProvider);
  return DeleteOrderUseCase(repository);
});
