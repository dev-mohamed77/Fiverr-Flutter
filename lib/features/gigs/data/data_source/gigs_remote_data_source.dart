// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dio/dio.dart';

import 'package:fiverr/core/service/network_service/network_service.dart';
import 'package:fiverr/features/gigs/data/model/gig_model.dart';

class UpdateGigData {
  final String? title;
  final String? description;
  final String? price;
  final String? categoryId;
  final String? subCategoryId;
  final String? coverImage;
  final String? deliveryTime;

  UpdateGigData({
    this.title,
    this.description,
    this.price,
    this.categoryId,
    this.subCategoryId,
    this.coverImage,
    this.deliveryTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "title": title,
      "description": description,
      "price": price,
      "category": categoryId,
      "subCategory": subCategoryId,
      "deliveryTime": deliveryTime,
    };
  }

  @override
  String toString() {
    return 'UpdateGigData(title: $title, description: $description, price: $price, categoryId: $categoryId, subCategoryId: $subCategoryId, coverImage: $coverImage, deliveryTime: $deliveryTime)';
  }
}

abstract class GigsRemoteDataSource {
  Future<GigModel> createGig({
    required String title,
    required String description,
    required String price,
    required String categoryId,
    required String subCategoryId,
    required File coverImage,
    required List<File> images,
    required String deliveryTime,
  });
  Future<List<GigModel>> getGigsBySubCategoryId(
    String subCategoryID, {
    String? page,
    String? limit,
    String? deliveryTime,
    String? maxPrice,
    String? minPrice,
    String? language,
    String? country,
  });
  Future<List<GigModel>> getGigsByCategoryId(
    String categoryID, {
    String? page,
    String? limit,
  });

  Future<List<GigModel>> getGigsBySellerId(
    String sellerID, {
    String? page,
    String? limit,
  });

  Future<GigModel> updateGigById(
    String gigId, {
    required UpdateGigData updateGig,
  });

  Future<String> deleteGigById(String gigId);
}

class GigsRemoteDataSourceImp implements GigsRemoteDataSource {
  final NetWorkService netWorkService;

  GigsRemoteDataSourceImp({required this.netWorkService});

  @override
  Future<GigModel> createGig({
    required String title,
    required String description,
    required String price,
    required String categoryId,
    required String subCategoryId,
    required File coverImage,
    required List<File> images,
    required String deliveryTime,
  }) async {
    final coverImageName = coverImage.path.split("/").last;
    List<MultipartFile> imagesFiles = [];

    for (File image in images) {
      final name = image.path.split("/").last;
      imagesFiles.add(await MultipartFile.fromFile(image.path, filename: name));
    }
    print("Title =============>>>$title");
    final response = await netWorkService.postData(
      "gigs",
      isFormData: true,
      data: {
        "title": title,
        "description": description,
        "price": price,
        "category": categoryId,
        "subCategory": subCategoryId,
        "deliveryTime": deliveryTime,
        "coverImage": await MultipartFile.fromFile(
          coverImage.path,
          filename: coverImageName,
        ),
        "images": imagesFiles
      },
    );

    final data = response.data["result"];

    return GigModel.fromMap(data);
  }

  @override
  Future<List<GigModel>> getGigsBySubCategoryId(
    String subCategoryID, {
    String? page,
    String? limit,
    String? deliveryTime,
    String? maxPrice,
    String? minPrice,
    String? language,
    String? country,
  }) async {
    final response = await netWorkService
        .getData("$subCategoryID/gigs-sub-category", queryParams: {
      "page": page,
      "limit": limit,
      "delivery-time": deliveryTime,
      "max-price": maxPrice,
      "min-price": minPrice,
      "language": language,
      "country": country,
    });

    final Iterable data = response.data["result"];

    final gigs = data.map((e) => GigModel.fromMap(e)).toList();

    return gigs;
  }

  @override
  Future<List<GigModel>> getGigsByCategoryId(
    String categoryID, {
    String? page,
    String? limit,
  }) async {
    final response =
        await netWorkService.getData("$categoryID/gigs-category", queryParams: {
      "page": page,
      "limit": limit,
    });

    final Iterable data = response.data["result"];

    final gigs = data.map((e) => GigModel.fromMap(e)).toList();

    return gigs;
  }

  @override
  Future<List<GigModel>> getGigsBySellerId(
    String sellerID, {
    String? page,
    String? limit,
  }) async {
    final response = await netWorkService.getData(
      "$sellerID/gigs-seller",
      queryParams: {
        "page": page,
        "limit": limit,
      },
    );

    final Iterable data = response.data["result"];

    final gigs = data.map((e) => GigModel.fromMap(e)).toList();

    return gigs;
  }

  @override
  Future<GigModel> updateGigById(
    String gigId, {
    required UpdateGigData updateGig,
  }) async {
    String? coverImageName;
    if (updateGig.coverImage != null) {
      coverImageName = updateGig.coverImage?.split("/").last;
    }

    final Map<String, dynamic> filterData = updateGig.toMap();

    // Remove keys with empty values
    filterData.removeWhere((key, value) => value == null || value == '');

    final response = await netWorkService.updateData(
      "gigs/$gigId",
      isFormData: updateGig.coverImage != null ? true : false,
      data: updateGig.coverImage != null
          ? {
              'coverImage': await MultipartFile.fromFile(
                updateGig.coverImage!,
                filename: coverImageName,
              ),
            }
          : filterData,
    );

    final data = response.data['result'];

    return GigModel.fromMap(data);
  }

  @override
  Future<String> deleteGigById(String gigId) async {
    final response = await netWorkService.deleteData("gigs/$gigId");

    final data = response.data['result'];

    return data;
  }
}
