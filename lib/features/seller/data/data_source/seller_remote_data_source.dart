// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dio/dio.dart';

import 'package:fiverr/core/service/network_service/network_service.dart';
import 'package:fiverr/features/seller/data/model/seller_model.dart';

class UpdateSeller {
  final String? fullName;
  final String? displayName;
  final String? description;
  final String? image;
  final String? website;
  UpdateSeller({
    this.fullName,
    this.displayName,
    this.description,
    this.image,
    this.website,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'displayName': displayName,
      'description': description,
      'image': image,
      'website': website,
    };
  }

  @override
  String toString() {
    return 'UpdateSeller(fullName: $fullName, displayName: $displayName, description: $description, image: $image, website: $website)';
  }
}

abstract class SellerRemoteDataSource {
  Future<SellerModel> createSeller({
    required String fullName,
    required String displayName,
    required String description,
    required String image,
    String? website,
  });
  Future<SellerModel> getSellerByID(String id);
  Future<SellerModel> getSellerByLoggedUser();
  Future<SellerModel> updateSeller(
    String id, {
    required UpdateSeller updateSeller,
  });
  Future<String> deleteSeller(String id);
}

class SellerRemoteDataSourceImp implements SellerRemoteDataSource {
  final NetWorkService netWorkService;
  SellerRemoteDataSourceImp({
    required this.netWorkService,
  });

  @override
  Future<SellerModel> createSeller({
    required String fullName,
    required String displayName,
    required String description,
    required String image,
    String? website,
  }) async {
    String fileName = image.split('/').last;
    final response = await netWorkService.postData(
      "seller/create-seller",
      data: {
        "fullName": fullName,
        "displayName": displayName,
        "description": description,
        "image": await MultipartFile.fromFile(
          image,
          filename: fileName,
        ),
        "website": website,
      },
      isFormData: true,
    );
    final data = response.data["result"];

    return SellerModel.fromMap(data);
  }

  @override
  Future<SellerModel> getSellerByLoggedUser() async {
    final response = await netWorkService.getData("seller/get-seller");

    final data = response.data["result"];

    return SellerModel.fromMap(data);
  }

  @override
  Future<SellerModel> getSellerByID(String id) async {
    final response = await netWorkService.getData("seller/$id");

    final data = response.data["result"];

    return SellerModel.fromMap(data);
  }

  @override
  Future<SellerModel> updateSeller(
    String id, {
    required UpdateSeller updateSeller,
  }) async {
    String? fileName = updateSeller.image?.split('/').last;

    final Map<String, dynamic> filterData = updateSeller.toMap();

    // Remove keys with empty values
    filterData.removeWhere((key, value) => value == null || value == '');

    final response = await netWorkService.updateData(
      "seller/update-seller",
      data: updateSeller.image != null
          ? {
              "image": await MultipartFile.fromFile(
                updateSeller.image!,
                filename: fileName,
              )
            }
          : filterData,
      isFormData: updateSeller.image != null ? true : false,
    );
    final data = response.data["result"];

    return SellerModel.fromMap(data);
  }

  @override
  Future<String> deleteSeller(String id) async {
    final response = await netWorkService.deleteData("seller/$id");

    final data = response.data["result"];

    return data;
  }
}
