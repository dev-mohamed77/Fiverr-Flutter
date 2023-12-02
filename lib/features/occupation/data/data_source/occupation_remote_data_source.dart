// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fiverr/core/service/network_service/network_service.dart';
import 'package:fiverr/features/occupation/data/model/occupation_model.dart';

abstract class OccupationRemoteDataSource {
  Future<OccupationModel> createOccupation({
    required String sellerId,
    required String specialization,
    required String occupation,
    required String from,
    required String to,
  });
  Future<List<OccupationModel>> getOccupationBySellerId(String sellerId);
  Future<OccupationModel> updateOccupation(
    String id, {
    String? specialization,
    String? occupation,
    String? from,
    String? to,
  });
  Future<String> deleteOccupation(String id);
}

class OccupationRemoteDataSourceImp implements OccupationRemoteDataSource {
  final NetWorkService netWorkService;
  OccupationRemoteDataSourceImp({
    required this.netWorkService,
  });

  @override
  Future<OccupationModel> createOccupation({
    required String sellerId,
    required String specialization,
    required String occupation,
    required String from,
    required String to,
  }) async {
    final response = await netWorkService.postData("occupations", data: {
      "seller": sellerId,
      "specialization": specialization,
      "occupation": occupation,
      "from": from,
      "to": to
    });

    final data = response.data["result"];

    return OccupationModel.fromMap(data);
  }

  @override
  Future<List<OccupationModel>> getOccupationBySellerId(String sellerId) async {
    final response = await netWorkService.getData(
      "$sellerId/occupation-seller",
    );

    final Iterable data = response.data["result"];

    final occupations =
        data.map((occ) => OccupationModel.fromMap(occ)).toList();

    return occupations;
  }

  @override
  Future<OccupationModel> updateOccupation(
    String id, {
    String? specialization,
    String? occupation,
    String? from,
    String? to,
  }) async {
    final response = await netWorkService.updateData("occupations/$id", data: {
      "specialization": specialization,
      "occupation": occupation,
      "from": from,
      "to": to
    });

    final data = response.data["result"];

    return OccupationModel.fromMap(data);
  }

  @override
  Future<String> deleteOccupation(String id) async {
    final response = await netWorkService.deleteData(
      "occupations/$id",
    );

    final data = response.data["result"];

    return data;
  }
}
