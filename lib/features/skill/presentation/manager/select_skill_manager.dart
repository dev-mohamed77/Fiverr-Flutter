import 'package:fiverr/features/skill/domain/entity/skill_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectSellerSkillProvider = StateProvider<String?>((ref) => null);
final selectSellerSkillLevelProvider =
    StateProvider.autoDispose<String?>((ref) => null);

final selectDeleteSkillProvider = StateProvider<SkillEntity?>((ref) => null);
