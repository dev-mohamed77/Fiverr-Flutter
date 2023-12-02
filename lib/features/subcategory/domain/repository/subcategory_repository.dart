import 'package:fiverr/core/service/network_service/api/api_result.dart';
import 'package:fiverr/features/subcategory/domain/entity/sub_category_entity.dart';

abstract class SubCategoryRepository {
  Future<ApiResult<SubCategoryEntity>> addSubCategory({
    required String name,
    required String category,
  });
  Future<ApiResult<List<SubCategoryEntity>>> getSubCategories({
    String? page,
    String? limit,
  });
  Future<ApiResult<List<SubCategoryEntity>>> getSubCategoriesByCategoryID(
    String id, {
    String? page,
    String? limit,
  });
  Future<ApiResult<SubCategoryEntity>> getSubCategoryByID(String id);
  Future<ApiResult<SubCategoryEntity>> updateSubCategoryByID(String id,
      {required String name});
  Future<ApiResult<String>> deleteSubCategoryByID(String id);
}
