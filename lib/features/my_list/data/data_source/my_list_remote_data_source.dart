// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fiverr/core/service/network_service/network_service.dart';
import 'package:fiverr/features/my_list/data/model/my_list_model.dart';

abstract class MyListRemoteDataSource {
  Future<MyListModel> addFavorite({required String gigId});
  Future<List<MyListModel>> getFavoritesByUser();
  Future<String> deleteFavorite({required String gigId});
}

class MyListRemoteDataSourceImp implements MyListRemoteDataSource {
  final NetWorkService networkService;
  MyListRemoteDataSourceImp({
    required this.networkService,
  });

  @override
  Future<MyListModel> addFavorite({required String gigId}) async {
    final response =
        await networkService.postData("favorites/user", data: {"gig": gigId});

    final data = response.data["result"];

    return MyListModel.fromMap(data);
  }

  @override
  Future<String> deleteFavorite({required String gigId}) async {
    final response =
        await networkService.deleteData("favorites/user", data: {"gig": gigId});

    final data = response.data["result"];

    return data;
  }

  @override
  Future<List<MyListModel>> getFavoritesByUser() async {
    final response = await networkService.getData(
      "favorites/user",
    );

    final Iterable data = response.data["result"];

    List<MyListModel> myListModels =
        data.map((e) => MyListModel.fromMap(e)).toList();

    return myListModels;
  }
}
