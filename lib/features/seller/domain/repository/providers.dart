import 'package:fiverr/features/seller/data/data_source/providers.dart';
import 'package:fiverr/features/seller/data/repository/seller_repository.dart';
import 'package:fiverr/features/seller/domain/repository/seller_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sellerRepositoryProvider = Provider<ISellerRepository>((ref) {
  final dataSource = ref.watch(sellerRemoteDataSourceProvider);

  return SellerRepositoryImp(remoteDataSource: dataSource);
});
