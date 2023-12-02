import 'package:fiverr/core/service/network_service/api/api_result.dart';
import 'package:fiverr/features/auth/domain/entity/signin_entity.dart';

abstract class AuthRepository {
  Future<ApiResult<SignInEntity>> signInFromFacebook();
  Future<ApiResult<SignInEntity>> signInFromGoogle();
}
