import 'package:fiverr/core/service/network_service/api/api_result.dart';
import 'package:fiverr/features/auth/domain/entity/signin_entity.dart';
import 'package:fiverr/features/profile/domain/entity/user_entity.dart';
import 'package:fiverr/features/auth/domain/repository/auth_repository.dart';

abstract class SignInRepository extends AuthRepository {
  Future<ApiResult<SignInEntity>> signIn({
    required String email,
    required String password,
  });
  Future<ApiResult<String>> forgetPassword({
    required String email,
  });

  Future<ApiResult<UserEntity>> verifyPassResetCode({
    required String resetCode,
  });

  Future<ApiResult<SignInEntity>> resetPassword({
    required String email,
    required String password,
  });
}
