// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/core/service/network_service/api/api_result.dart';
import 'package:fiverr/features/auth/data/model/signin_model.dart';
import 'package:fiverr/features/profile/data/data_source/user_remote_data_source.dart';
import 'package:fiverr/features/profile/domain/entity/user_entity.dart';
import 'package:fiverr/features/profile/domain/repository/user_repository.dart';

class UserRepositoryImp implements IUserRepository {
  final UserRemoteDataSource remoteDataSource;
  UserRepositoryImp({
    required this.remoteDataSource,
  });

  @override
  Future<ApiResult<UserEntity>> getMe(String token) async {
    try {
      final result = await remoteDataSource.getMe(token);

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<UserEntity>> updateUser(
    String token, {
    String? name,
    String? gender,
    String? phone,
    int? age,
    String? country,
  }) async {
    try {
      final result = await remoteDataSource.updateUser(
        token,
        name: name,
        gender: gender,
        phone: phone,
        age: age,
        country: country,
      );

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<SignInModel>> changePassword(
    String token, {
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final result = await remoteDataSource.changePassword(
        token,
        currentPassword: currentPassword,
        newPassword: newPassword,
      );

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }
}
