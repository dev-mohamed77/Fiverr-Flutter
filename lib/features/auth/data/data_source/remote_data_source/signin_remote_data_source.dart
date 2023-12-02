import 'package:fiverr/core/service/network_service/dio_service.dart';
import 'package:fiverr/features/auth/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:fiverr/features/auth/data/model/signin_model.dart';
import 'package:fiverr/features/profile/data/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class SignInRemoteDataSource extends AuthRemoteDataSource {
  Future<SignInModel> signIn({
    required String email,
    required String password,
  });

  Future<String> forgetPassword({
    required String email,
  });

  Future<UserModel> verifyPassResetCode({
    required String resetCode,
  });

  Future<SignInModel> resetPassword({
    required String email,
    required String password,
  });
}

class SignInRemoteDataSourceImp extends AuthRemoteDataSourceImp
    implements SignInRemoteDataSource {
  SignInRemoteDataSourceImp({required super.netWorkService});

  @override
  Future<SignInModel> signIn({
    required String email,
    required String password,
  }) async {
    final response = await netWorkService.postData(
      "auth/signin",
      data: {"email": email, "password": password},
    );

    final data = response.data;

    return SignInModel.fromMap(data);
  }

  @override
  Future<String> forgetPassword({required String email}) async {
    final response = await netWorkService.postData(
      "auth/forget-password",
      data: {"email": email},
    );

    final data = response.data["result"];

    return data;
  }

  @override
  Future<UserModel> verifyPassResetCode({required String resetCode}) async {
    final response = await netWorkService.postData(
      "auth/verify-reset-code",
      data: {"resetCode": resetCode},
    );

    final data = response.data["result"];

    return UserModel.fromMap(data);
  }

  @override
  Future<SignInModel> resetPassword({
    required String email,
    required String password,
  }) async {
    final response = await netWorkService.updateData(
      "auth/reset-password",
      data: {"email": email, "password": password},
    );

    final data = response.data;

    return SignInModel.fromMap(data);
  }
}

final signInRemoteDataSourceProvider = Provider((ref) {
  final dioService = ref.watch(dioServiceProvider);

  return SignInRemoteDataSourceImp(netWorkService: dioService);
});
