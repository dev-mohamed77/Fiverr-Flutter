import 'package:fiverr/features/skill/data/data_source/providers.dart';
import 'package:fiverr/features/skill/data/repository/skill_repository.dart';
import 'package:fiverr/features/skill/domain/repository/skill_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final skillRepositoryProvider = Provider<ISkillRepository>((ref) {
  final remoteDataSource = ref.watch(skillRemoteDataSourceProvider);

  return SkillRepositoryImp(remoteDataSource: remoteDataSource);
});
