import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/auth/domain/entity/signin_entity.dart';
import 'package:fiverr/features/auth/domain/repository/signin_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResetPasswordUseCase extends StateNotifier<AsyncValue<SignInEntity?>> {
  final SignInRepository repo;
  ResetPasswordUseCase(this.repo, this.ref)
      : super(const AsyncValue.data(null));
  final Ref ref;

  Future<void> execute({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();

    final result = await repo.resetPassword(email: email, password: password);

    result.when(
      success: (data) {
        state = AsyncValue.data(data);
      },
      failure: (errorHandle) => state = AsyncValue.error(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      ),
    );
  }
}
