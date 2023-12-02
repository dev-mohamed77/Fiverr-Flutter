// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fiverr/core/service/network_service/network_service.dart';
import 'package:fiverr/features/subcategory/data/model/subcategory_model.dart';

abstract class SubCategoryRemoteDataSource {
  Future<SubCategoryModel> addSubCategory({
    required String name,
    required String category,
  });
  Future<List<SubCategoryModel>> getSubCategories({
    String? page,
    String? limit,
  });
  Future<List<SubCategoryModel>> getSubCategoriesByCategoryID(
    String id, {
    String? page,
    String? limit,
  });
  Future<SubCategoryModel> getSubCategoryByID(
    String id,
  );
  Future<SubCategoryModel> updateSubCategoryByID(
    String id, {
    required String name,
  });
  Future<String> deleteSubCategoryByID(
    String id,
  );
}

class SubCategoryRemoteDataSourceImp implements SubCategoryRemoteDataSource {
  final NetWorkService netWorkService;
  SubCategoryRemoteDataSourceImp({
    required this.netWorkService,
  });

  @override
  Future<SubCategoryModel> addSubCategory({
    required String name,
    required String category,
  }) async {
    final response = await netWorkService.postData(
      "sub-categories",
      data: {
        "name": name,
        "category": category,
      },
    );

    final data = response.data["result"];

    return SubCategoryModel.fromMap(data);
  }

  @override
  Future<List<SubCategoryModel>> getSubCategories({
    String? page,
    String? limit,
  }) async {
    final response = await netWorkService.getData(
      "sub-categories",
      queryParams: {
        "page": page,
        "limit": limit,
      },
    );

    final Iterable data = response.data["result"];

    final subCategories = data
        .map((subCategory) => SubCategoryModel.fromMap(subCategory))
        .toList();

    return subCategories;
  }

  @override
  Future<List<SubCategoryModel>> getSubCategoriesByCategoryID(
    String id, {
    String? page,
    String? limit,
  }) async {
    final response = await netWorkService.getData(
      "$id/sub-categories",
      queryParams: {
        "page": page,
        "limit": limit,
      },
    );

    final Iterable data = response.data["result"];

    final subCategories = data
        .map((subCategory) => SubCategoryModel.fromMap(subCategory))
        .toList();

    return subCategories;
  }

  @override
  Future<SubCategoryModel> getSubCategoryByID(String id) async {
    final response = await netWorkService.getData(
      "sub-categories/$id",
    );

    final data = response.data["result"];

    return SubCategoryModel.fromMap(data);
  }

  @override
  Future<SubCategoryModel> updateSubCategoryByID(
    String id, {
    required String name,
  }) async {
    final response = await netWorkService.updateData(
      "sub-categories/$id",
      data: {
        "name": name,
      },
    );

    final data = response.data["result"];

    return SubCategoryModel.fromMap(data);
  }

  @override
  Future<String> deleteSubCategoryByID(String id) async {
    final response = await netWorkService.deleteData(
      "sub-categories/$id",
    );
    final data = response.data["result"];

    return data;
  }
}
