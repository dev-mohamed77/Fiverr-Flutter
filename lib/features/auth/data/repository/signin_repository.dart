import 'package:fiverr/core/providers/token/token_provider.dart';
import 'package:fiverr/core/providers/user/user_provider.dart';
import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/core/service/network_service/api/api_result.dart';
import 'package:fiverr/features/auth/data/data_source/local_data_source.dart/provider.dart';
import 'package:fiverr/features/auth/data/data_source/local_data_source.dart/user_local_data_source.dart';
import 'package:fiverr/features/auth/data/data_source/remote_data_source/signin_remote_data_source.dart';
import 'package:fiverr/features/auth/data/repository/auth_repository.dart';
import 'package:fiverr/features/auth/domain/entity/signin_entity.dart';
import 'package:fiverr/features/profile/domain/entity/user_entity.dart';
import 'package:fiverr/features/auth/domain/repository/signin_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInRepositoryImp extends AuthRepositoryImp
    implements SignInRepository {
  SignInRepositoryImp({
    required this.signInRemoteDataSource,
    required this.authLocalDataSource,
    required this.ref,
  }) : super(
          authRemoteDataSource: signInRemoteDataSource,
          authLocalDataSource: authLocalDataSource,
          ref: ref,
        );

  final SignInRemoteDataSource signInRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;
  final Ref ref;

  @override
  Future<ApiResult<SignInEntity>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await signInRemoteDataSource.signIn(
        email: email,
        password: password,
      );

      await authLocalDataSource.addToken(result.token);
      ref.read(userProvider.notifier).update((state) => result.user);
      ref.read(tokenProvider.notifier).update((state) => result.token);

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<String>> forgetPassword({required String email}) async {
    try {
      final result = await signInRemoteDataSource.forgetPassword(
        email: email,
      );

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<UserEntity>> verifyPassResetCode({
    required String resetCode,
  }) async {
    try {
      final result = await signInRemoteDataSource.verifyPassResetCode(
        resetCode: resetCode,
      );

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<SignInEntity>> resetPassword({
    required String email,
    required String password,
  }) async {
    try {
      final result = await signInRemoteDataSource.resetPassword(
        email: email,
        password: password,
      );

      await authLocalDataSource.addToken(result.token);
      ref.read(userProvider.notifier).update((state) => result.user);
      ref.read(tokenProvider.notifier).state = result.token;

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }
}

final signInRepositoryProvider = Provider((ref) {
  final authLocalDataSource = ref.watch(authLocalDataSourceProvider);
  final signInRemoteDataSource = ref.watch(signInRemoteDataSourceProvider);
  return SignInRepositoryImp(
    signInRemoteDataSource: signInRemoteDataSource,
    authLocalDataSource: authLocalDataSource,
    ref: ref,
  );
});
