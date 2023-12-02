import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fiverr/core/service/network_service/network_service.dart';
import 'package:fiverr/features/gigs/data/model/gig_model.dart';

abstract class GigImagesRemoteDataSource {
  Future<GigImageModel> addImageOfTheGig(String gigId, File image);

  Future<String> deleteGigImages(String imageId, String gigId);
}

class GigImagesRemoteDataSourceImp implements GigImagesRemoteDataSource {
  final NetWorkService netWorkService;

  GigImagesRemoteDataSourceImp({required this.netWorkService});

  @override
  Future<GigImageModel> addImageOfTheGig(String gigId, File image) async {
    final response = await netWorkService.postData(
      "gig-images",
      isFormData: true,
      data: {
        "gig": gigId,
        "image": await MultipartFile.fromFile(image.path),
      },
    );

    final data = response.data;

    return GigImageModel.fromMap(data);
  }

  @override
  Future<String> deleteGigImages(String imageId, String gigId) async {
    final response = await netWorkService.deleteData(
      "gig-images$imageId",
      data: {
        "gig": gigId,
      },
    );

    final data = response.data;

    return data;
  }
}
