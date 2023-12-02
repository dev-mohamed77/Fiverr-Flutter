import 'dart:io';

import 'package:fiverr/core/service/network_service/api/api_result.dart';
import 'package:fiverr/features/gigs/data/model/gig_model.dart';

abstract class GigImagesRepository {
  Future<ApiResult<GigImageModel>> addImageOfTheGig(String gigId, File image);

  Future<ApiResult<String>> deleteImageOfTheGig(String imageId, String gigId);
}
