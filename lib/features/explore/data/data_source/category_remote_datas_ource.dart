import 'package:fiverr/core/service/network_service/network_service.dart';
import 'package:fiverr/features/explore/data/model/category_model.dart';

abstract class CategoryRemoteDataSource {
  Future<CategoryModel> addCategory({
    required String name,
  });
  Future<List<CategoryModel>> getCategories({
    String? page,
    String? limit,
  });
  Future<CategoryModel> getCategoryByID({
    required String id,
  });
  Future<CategoryModel> updateCategoryByID(
    String id, {
    required String name,
  });
  Future<String> deleteCategoryByID(
    String id,
  );
}

class CategoryRemoteDataSourceImp implements CategoryRemoteDataSource {
  final NetWorkService netWorkService;

  CategoryRemoteDataSourceImp({required this.netWorkService});

  @override
  Future<CategoryModel> addCategory({
    required String name,
  }) async {
    final response = await netWorkService.postData(
      "categories",
      data: {
        "name": name,
      },
    );

    final data = response.data["result"];

    return CategoryModel.fromMap(data);
  }

  @override
  Future<List<CategoryModel>> getCategories({
    String? page,
    String? limit,
  }) async {
    final response = await netWorkService.getData(
      "categories",
      queryParams: {
        "page": page,
        "limit": limit,
      },
    );

    final Iterable data = response.data["result"];

    final List<CategoryModel> categoryModel =
        data.map((category) => CategoryModel.fromMap(category)).toList();

    return categoryModel;
  }

  @override
  Future<CategoryModel> getCategoryByID({
    required String id,
  }) async {
    final response = await netWorkService.getData(
      "categories/$id",
    );

    final data = response.data["result"];

    return CategoryModel.fromMap(data);
  }

  @override
  Future<CategoryModel> updateCategoryByID(
    String id, {
    required String name,
  }) async {
    final response = await netWorkService.updateData(
      "categories/$id",
      data: {
        "name": name,
      },
    );
    final data = response.data["result"];

    return CategoryModel.fromMap(data);
  }

  @override
  Future<String> deleteCategoryByID(
    String id,
  ) async {
    final response = await netWorkService.deleteData(
      "categories/$id",
    );
    final data = response.data["result"];

    return data;
  }
}
