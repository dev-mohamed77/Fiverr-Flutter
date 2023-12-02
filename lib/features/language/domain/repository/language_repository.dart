import 'package:fiverr/core/service/network_service/api/api_result.dart';
import 'package:fiverr/features/language/domain/entity/language_entity.dart';

abstract class ILanguageRepository {
  Future<ApiResult<LanguageEntity>> createLanguage({
    required String language,
    required String level,
    required String sellerId,
  });
  Future<ApiResult<List<LanguageEntity>>> getLanguagesBySellerId(
    String sellerId,
  );
  Future<ApiResult<LanguageEntity>> updateLanguage(
    String id, {
    String? language,
    String? level,
  });

  Future<ApiResult<String>> deleteLanguage(String id);
}
