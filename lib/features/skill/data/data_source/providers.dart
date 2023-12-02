import 'package:fiverr/core/service/network_service/dio_service.dart';
import 'package:fiverr/features/skill/data/data_source/skill_remote_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final skillRemoteDataSourceProvider = Provider<SkillRemoteDataSource>((ref) {
  final dioService = ref.watch(dioServiceProvider);

  return SkillRemoteDataSourceImp(netWorkService: dioService);
});
