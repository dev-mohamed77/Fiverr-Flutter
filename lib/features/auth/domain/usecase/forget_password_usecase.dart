import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/auth/domain/repository/signin_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgetPasswordUseCase extends StateNotifier<AsyncValue<String?>> {
  final SignInRepository repo;
  ForgetPasswordUseCase(this.repo) : super(const AsyncValue.data(null));

  Future<void> execute({
    required String email,
  }) async {
    state = const AsyncValue.loading();

    final result = await repo.forgetPassword(email: email);

    state = result.when(
      success: (data) => AsyncValue.data(data),
      failure: (errorHandle) => AsyncValue.error(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      ),
    );
  }
}
