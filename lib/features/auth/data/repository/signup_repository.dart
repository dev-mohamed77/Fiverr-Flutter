import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/core/service/network_service/api/api_result.dart';
import 'package:fiverr/features/auth/data/data_source/remote_data_source/signup_remote_data_source.dart';
import 'package:fiverr/features/profile/domain/entity/user_entity.dart';
import 'package:fiverr/features/auth/domain/repository/signup_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpRepositoryImp implements SignUpRepository {
  SignUpRepositoryImp({required this.signUpRemoteDataSource});

  final SignUpRemoteDataSource signUpRemoteDataSource;

  @override
  Future<ApiResult<UserEntity>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final result = await signUpRemoteDataSource.signUp(
        name: name,
        email: email,
        password: password,
      );

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }
}

final signUpRepositoryProvider = Provider((ref) {
  final signUpRemoteDataSource = ref.watch(signUpRemoteDataSourceProvider);
  return SignUpRepositoryImp(signUpRemoteDataSource: signUpRemoteDataSource);
});
