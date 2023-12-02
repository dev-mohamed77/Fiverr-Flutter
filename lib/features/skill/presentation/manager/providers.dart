import 'dart:async';

import 'package:fiverr/features/skill/domain/entity/skill_entity.dart';
import 'package:fiverr/features/skill/domain/repository/providers.dart';
import 'package:fiverr/features/skill/domain/usecase/create_skill_usecase.dart';
import 'package:fiverr/features/skill/domain/usecase/delete_skill_usecase.dart';
import 'package:fiverr/features/skill/domain/usecase/get_skills_by_seller_id_usecase.dart';
import 'package:fiverr/features/skill/domain/usecase/update_skill_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final createSkillUseCaseProvider = StateNotifierProvider.autoDispose<
    CreateSkillUseCase, AsyncValue<SkillEntity?>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });

  final repo = ref.watch(skillRepositoryProvider);
  return CreateSkillUseCase(repo);
});

final getSkillsBySellerIdUseCaseProvider = StateNotifierProvider.autoDispose<
    GetSkillsBySellerIdUseCase, AsyncValue<List<SkillEntity>?>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });

  final repo = ref.watch(skillRepositoryProvider);
  return GetSkillsBySellerIdUseCase(repo);
});

final updateSkillUseCaseProvider = StateNotifierProvider.autoDispose<
    UpdateSkillUseCase, AsyncValue<SkillEntity?>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });

  final repo = ref.watch(skillRepositoryProvider);
  return UpdateSkillUseCase(repo);
});

final deleteSkillUseCaseProvider =
    StateNotifierProvider.autoDispose<DeleteSkillUseCase, AsyncValue<String?>>(
        (ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });

  final repo = ref.watch(skillRepositoryProvider);
  return DeleteSkillUseCase(repo);
});
