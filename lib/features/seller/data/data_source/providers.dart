import 'package:fiverr/core/service/network_service/dio_service.dart';
import 'package:fiverr/features/seller/data/data_source/seller_remote_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sellerRemoteDataSourceProvider = Provider<SellerRemoteDataSource>((ref) {
  final dioService = ref.watch(dioServiceProvider);

  return SellerRemoteDataSourceImp(netWorkService: dioService);
});
