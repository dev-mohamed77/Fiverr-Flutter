import 'package:fiverr/core/service/network_service/api/api_result.dart';
import 'package:fiverr/features/skill/domain/entity/skill_entity.dart';

abstract class ISkillRepository {
  Future<ApiResult<SkillEntity>> createSkill({
    required String sellerId,
    required String skill,
    required String level,
  });
  Future<ApiResult<List<SkillEntity>>> getSkillsBySellerId(
    String sellerId,
  );
  Future<ApiResult<SkillEntity>> updateSkill(
    String id, {
    String? skill,
    String? level,
  });

  Future<ApiResult<String>> deleteSkill(String id);
}
