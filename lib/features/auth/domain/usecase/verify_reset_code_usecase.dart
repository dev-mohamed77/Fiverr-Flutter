import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/profile/domain/entity/user_entity.dart';
import 'package:fiverr/features/auth/domain/repository/signin_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerifyResetCodeUseCase extends StateNotifier<AsyncValue<UserEntity?>> {
  final SignInRepository repo;
  VerifyResetCodeUseCase(this.repo) : super(const AsyncValue.data(null));

  Future<void> execute({
    required String resetCode,
  }) async {
    state = const AsyncValue.loading();

    final result = await repo.verifyPassResetCode(resetCode: resetCode);

    state = result.when(
      success: (data) => AsyncValue.data(data),
      failure: (errorHandle) => AsyncValue.error(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      ),
    );
  }
}
