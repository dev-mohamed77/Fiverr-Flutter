import 'package:fiverr/core/service/network_service/dio_service.dart';
import 'package:fiverr/core/service/network_service/network_service.dart';
import 'package:fiverr/features/profile/data/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class SignUpRemoteDataSource {
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  });
}

class SignUpRemoteDataSourceImp implements SignUpRemoteDataSource {
  final NetWorkService netWorkService;
  SignUpRemoteDataSourceImp({required this.netWorkService});

  @override
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await netWorkService.postData(
      "auth/signup",
      data: {
        "name": name,
        "email": email,
        "password": password,
      },
    );

    final data = response.data["result"];

    return UserModel.fromMap(data);
  }
}

final signUpRemoteDataSourceProvider = Provider((ref) {
  final dioService = ref.watch(dioServiceProvider);

  return SignUpRemoteDataSourceImp(netWorkService: dioService);
});
