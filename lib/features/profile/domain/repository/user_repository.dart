import 'package:fiverr/core/service/network_service/api/api_result.dart';
import 'package:fiverr/features/auth/data/model/signin_model.dart';
import 'package:fiverr/features/profile/domain/entity/user_entity.dart';

abstract class IUserRepository {
  Future<ApiResult<UserEntity>> getMe(String token);
  Future<ApiResult<UserEntity>> updateUser(
    String token, {
    String? name,
    String? gender,
    String? phone,
    int? age,
    String? country,
  });
  Future<ApiResult<SignInModel>> changePassword(
    String token, {
    required String currentPassword,
    required String newPassword,
  });
}
