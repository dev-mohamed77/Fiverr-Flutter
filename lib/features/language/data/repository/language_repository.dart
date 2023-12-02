// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/core/service/network_service/api/api_result.dart';
import 'package:fiverr/features/language/data/data_source/language_remote_data_source.dart';
import 'package:fiverr/features/language/domain/entity/language_entity.dart';
import 'package:fiverr/features/language/domain/repository/language_repository.dart';

class LanguageRepositoryImp implements ILanguageRepository {
  final LanguageRemoteDataSource remoteDataSource;

  LanguageRepositoryImp({
    required this.remoteDataSource,
  });

  @override
  Future<ApiResult<LanguageEntity>> createLanguage({
    required String language,
    required String level,
    required String sellerId,
  }) async {
    try {
      final result = await remoteDataSource.createLanguage(
        language: language,
        level: level,
        sellerId: sellerId,
      );

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<List<LanguageEntity>>> getLanguagesBySellerId(
    String sellerId,
  ) async {
    try {
      final result = await remoteDataSource.getLanguagesBySellerId(sellerId);

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<LanguageEntity>> updateLanguage(
    String id, {
    String? language,
    String? level,
  }) async {
    try {
      final result = await remoteDataSource.updateLanguage(
        id,
        language: language,
        level: level,
      );

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<String>> deleteLanguage(String id) async {
    try {
      final result = await remoteDataSource.deleteLanguage(id);

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }
}
