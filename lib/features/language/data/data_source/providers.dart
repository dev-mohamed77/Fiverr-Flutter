import 'package:fiverr/core/service/network_service/dio_service.dart';
import 'package:fiverr/features/language/data/data_source/language_remote_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final languageRemoteDataSourceProvider =
    Provider<LanguageRemoteDataSource>((ref) {
  final dioService = ref.watch(dioServiceProvider);

  return LanguageRemoteDataSourceImp(netWorkService: dioService);
});
