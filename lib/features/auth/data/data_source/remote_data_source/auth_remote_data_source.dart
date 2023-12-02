// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fiverr/core/service/network_service/dio_service.dart';
import 'package:fiverr/core/service/network_service/network_service.dart';
import 'package:fiverr/features/auth/data/model/signin_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AuthRemoteDataSource {
  Future<SignInModel> signInFromFacebook({
    required String name,
    required String email,
    required String password,
  });
  Future<SignInModel> signInFromGoogle({
    required String name,
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImp implements AuthRemoteDataSource {
  final NetWorkService netWorkService;
  AuthRemoteDataSourceImp({
    required this.netWorkService,
  });

  @override
  Future<SignInModel> signInFromFacebook({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await netWorkService.postData(
      "auth/register-by-google",
      data: {
        "name": name,
        "email": email,
        "password": password,
      },
    );

    final data = response.data;

    return SignInModel.fromMap(data);
  }

  @override
  Future<SignInModel> signInFromGoogle({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await netWorkService.postData(
      "auth/register-by-google",
      data: {"name": name, "email": email, "password": password},
    );

    final data = response.data;

    return SignInModel.fromMap(data);
  }
}

final authRemoteDataSourceProvider = Provider((ref) {
  final dioService = ref.watch(dioServiceProvider);

  return AuthRemoteDataSourceImp(netWorkService: dioService);
});
