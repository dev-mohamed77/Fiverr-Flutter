// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fiverr/core/service/network_service/network_service.dart';
import 'package:fiverr/features/gigs/data/model/gig_model.dart';

abstract class GigDetailsRemoteDataSource {
  Future<GigModel> getGigByID({
    required String id,
  });
}

class GigDetailsRemoteDataSourceImp implements GigDetailsRemoteDataSource {
  final NetWorkService netWorkService;
  GigDetailsRemoteDataSourceImp({
    required this.netWorkService,
  });

  @override
  Future<GigModel> getGigByID({
    required String id,
  }) async {
    final response = await netWorkService.getData("gigs/$id");

    final data = response.data["result"];

    return GigModel.fromMap(data);
  }
}
