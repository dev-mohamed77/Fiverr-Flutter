// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fiverr/core/service/network_service/network_service.dart';
import 'package:fiverr/features/auth/data/model/signin_model.dart';
import 'package:fiverr/features/profile/data/model/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getMe(String token);
  Future<UserModel> updateUser(
    String token, {
    String? name,
    String? gender,
    String? phone,
    int? age,
    String? country,
  });
  Future<SignInModel> changePassword(
    String token, {
    required String currentPassword,
    required String newPassword,
  });
}

class UserRemoteDataSourceImp implements UserRemoteDataSource {
  final NetWorkService networkService;
  UserRemoteDataSourceImp({
    required this.networkService,
  });

  @override
  Future<UserModel> getMe(String token) async {
    final response = await networkService.getData(
      "users/get-me",
      token: "Bearer $token",
    );
    final data = response.data["result"];

    return UserModel.fromMap(data);
  }

  @override
  Future<UserModel> updateUser(
    String token, {
    String? name,
    String? gender,
    String? phone,
    int? age,
    String? country,
  }) async {
    final response = await networkService.updateData(
      "users/update-user",
      data: {
        "name": name,
        "gender": gender,
        "phone": phone,
        "age": age,
        "country": country,
      },
      token: "Bearer $token",
    );

    final data = response.data["result"];

    return UserModel.fromMap(data);
  }

  @override
  Future<SignInModel> changePassword(
    String token, {
    required String currentPassword,
    required String newPassword,
  }) async {
    final response = await networkService.updateData(
      "users/change-password",
      data: {
        "currentPassword": currentPassword,
        "newPassword": newPassword,
      },
      token: "Bearer $token",
    );
    final data = response.data;

    return SignInModel.fromMap(data);
  }
}
