// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:fiverr/core/providers/token/token_provider.dart';
import 'package:fiverr/core/providers/user/user_provider.dart';
import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/core/service/network_service/api/api_result.dart';
import 'package:fiverr/features/auth/data/data_source/local_data_source.dart/provider.dart';
import 'package:fiverr/features/auth/data/data_source/local_data_source.dart/user_local_data_source.dart';
import 'package:fiverr/features/auth/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:fiverr/features/auth/domain/entity/signin_entity.dart';
import 'package:fiverr/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;
  final Ref ref;
  AuthRepositoryImp({
    required this.authRemoteDataSource,
    required this.authLocalDataSource,
    required this.ref,
  });

  @override
  Future<ApiResult<SignInEntity>> signInFromFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance
          .login(permissions: ['email', 'public_profile']);

      switch (result.status) {
        case LoginStatus.success:
          final userData = await FacebookAuth.instance
              .getUserData(fields: "name,email,picture.width(200),id");

          final response = await authRemoteDataSource.signInFromFacebook(
            name: userData["name"],
            email: "mohamed@gmail.com",
            password: userData["id"],
          );
          await authLocalDataSource.addToken(response.token);

          return ApiResult.success(response);

        case LoginStatus.failed:
          return ApiResult.failure(
            ErrorHandle.badRequest(result.message ??
                "It seems that there was an error in the registration"),
          );

        case LoginStatus.cancelled:
          return ApiResult.failure(
            ErrorHandle.badRequest(
                result.message ?? "The operation has been cancelled"),
          );
        case LoginStatus.operationInProgress:
          return ApiResult.failure(
            ErrorHandle.badRequest(result.message ?? "operation In Progress"),
          );
      }
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<SignInEntity>> signInFromGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      if (gUser != null) {
        final response = await authRemoteDataSource.signInFromGoogle(
          name: gUser.displayName ?? "",
          email: gUser.email,
          password: gUser.id,
        );

        await authLocalDataSource.addToken(response.token);
        ref.read(userProvider.notifier).update((state) => response.user);
        ref.read(tokenProvider.notifier).update((state) => response.token);

        return ApiResult.success(response);
      } else {
        return ApiResult.failure(
          const ErrorHandle.badRequest(
            "It seems that there was an error in the registration",
          ),
        );
      }
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }
}

final authRepositoryProvider = Provider((ref) {
  final authRemoteDataSource = ref.watch(authRemoteDataSourceProvider);
  final authLocalDataSource = ref.watch(authLocalDataSourceProvider);
  return AuthRepositoryImp(
    authRemoteDataSource: authRemoteDataSource,
    authLocalDataSource: authLocalDataSource,
    ref: ref,
  );
});
