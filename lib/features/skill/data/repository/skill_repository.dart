// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/core/service/network_service/api/api_result.dart';
import 'package:fiverr/features/skill/data/data_source/skill_remote_data_source.dart';
import 'package:fiverr/features/skill/domain/entity/skill_entity.dart';
import 'package:fiverr/features/skill/domain/repository/skill_repository.dart';

class SkillRepositoryImp implements ISkillRepository {
  final SkillRemoteDataSource remoteDataSource;
  SkillRepositoryImp({
    required this.remoteDataSource,
  });

  @override
  Future<ApiResult<SkillEntity>> createSkill({
    required String sellerId,
    required String skill,
    required String level,
  }) async {
    try {
      final result = await remoteDataSource.createSkill(
          skill: skill, level: level, sellerId: sellerId);

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<List<SkillEntity>>> getSkillsBySellerId(
      String sellerId) async {
    try {
      final result = await remoteDataSource.getSkillsBySellerId(sellerId);

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<SkillEntity>> updateSkill(
    String id, {
    String? skill,
    String? level,
  }) async {
    try {
      final result =
          await remoteDataSource.updateSkill(id, skill: skill, level: level);

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<String>> deleteSkill(String id) async {
    try {
      final result = await remoteDataSource.deleteSkill(id);

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }
}
