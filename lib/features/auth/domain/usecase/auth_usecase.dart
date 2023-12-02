import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/auth/domain/entity/signin_entity.dart';
import 'package:fiverr/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthUseCase extends StateNotifier<AsyncValue<SignInEntity?>> {
  final AuthRepository authRepository;

  AuthUseCase(this.authRepository) : super(const AsyncValue.data(null));

  Future<void> executeFaceBook() async {
    state = const AsyncLoading();

    final result = await authRepository.signInFromFacebook();

    state = result.when(
      success: (data) => AsyncValue.data(data),
      failure: (errorHandle) => AsyncError(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      ),
    );
  }

  Future<void> executeGoogle() async {
    state = const AsyncLoading();

    final result = await authRepository.signInFromGoogle();

    state = result.when(
      success: (data) => AsyncValue.data(data),
      failure: (errorHandle) => AsyncError(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      ),
    );
  }
}
