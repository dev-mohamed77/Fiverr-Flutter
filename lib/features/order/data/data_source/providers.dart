import 'package:fiverr/core/service/network_service/dio_service.dart';
import 'package:fiverr/features/order/data/data_source/order_remote_data_source.dart';
import 'package:fiverr/features/order/data/data_source/payment_remote_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderRemoteDataSourceProvide = Provider<OrderRemoteDataSource>((ref) {
  final dioService = ref.watch(dioServiceProvider);

  return OrderRemoteDataSourceImp(netWorkService: dioService);
});

final paymentDataSourceProvide = Provider<IStripePaymentDataSource>((ref) {
  return StripePaymentDataSourceImp(ref);
});
