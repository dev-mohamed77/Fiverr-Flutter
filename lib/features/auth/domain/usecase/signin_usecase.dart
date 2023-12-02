import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/auth/domain/repository/signin_repository.dart';
import 'package:fiverr/features/auth/domain/usecase/auth_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInUseCase extends AuthUseCase {
  final SignInRepository signInRepository;

  SignInUseCase(this.signInRepository) : super(signInRepository);

  execute({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    final result =
        await signInRepository.signIn(email: email, password: password);

    state = result.when(
      success: (data) => AsyncValue.data(data),
      failure: (errorHandle) => AsyncValue.error(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      ),
    );
  }
}
