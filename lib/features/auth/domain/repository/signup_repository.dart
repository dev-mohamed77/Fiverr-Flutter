import 'package:fiverr/core/service/network_service/api/api_result.dart';
import 'package:fiverr/features/profile/domain/entity/user_entity.dart';

abstract class SignUpRepository {
  Future<ApiResult<UserEntity>> signUp({
    required String name,
    required String email,
    required String password,
  });
}
