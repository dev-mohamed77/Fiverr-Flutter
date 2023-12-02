import 'package:fiverr/features/order/data/data_source/providers.dart';
import 'package:fiverr/features/order/data/repository/order_repository.dart';
import 'package:fiverr/features/order/data/repository/payment_repository.dart';
import 'package:fiverr/features/order/domain/repository/order_repository.dart';
import 'package:fiverr/features/order/domain/repository/payment_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderRepositoryProvider = Provider<IOrderRepository>((ref) {
  final orderDataSource = ref.watch(orderRemoteDataSourceProvide);

  return OrderRepositoryImp(orderDataSource: orderDataSource);
});

final paymentRepositoryProvider = Provider<IStripePaymentRepository>((ref) {
  final paymentDataSource = ref.watch(paymentDataSourceProvide);

  return StripePaymentRepositoryImp(stripePaymentDataSource: paymentDataSource);
});
