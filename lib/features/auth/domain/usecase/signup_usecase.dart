import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/profile/domain/entity/user_entity.dart';
import 'package:fiverr/features/auth/domain/repository/signup_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpUseCase extends StateNotifier<AsyncValue<UserEntity?>> {
  final SignUpRepository signUpRepository;
  SignUpUseCase(this.signUpRepository) : super(const AsyncValue.data(null));

  Future<void> execute({
    required String name,
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    final result = await signUpRepository.signUp(
      name: name,
      email: email,
      password: password,
    );

    state = result.when(
      success: (data) => AsyncValue.data(data),
      failure: (errorHandle) => AsyncValue.error(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      ),
    );
  }
}
