import 'package:fiverr/core/providers/token/token_provider.dart';
import 'package:fiverr/core/providers/user/user_provider.dart';
import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/auth/domain/entity/signin_entity.dart';
import 'package:fiverr/features/profile/domain/repository/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChangePasswordUseCase extends StateNotifier<AsyncValue<SignInEntity?>> {
  ChangePasswordUseCase(this.repo, this.ref)
      : super(const AsyncValue.data(null));

  final IUserRepository repo;
  final Ref ref;

  Future<void> execute({
    required String currentPassword,
    required String newPassword,
  }) async {
    state = const AsyncValue.loading();

    final token = ref.watch(tokenProvider);

    final result = await repo.changePassword(
      token.toString(),
      currentPassword: currentPassword,
      newPassword: newPassword,
    );

    result.when(success: (data) {
      state = AsyncValue.data(data);
      ref.read(userProvider.notifier).update((state) => data.user);
      ref.read(tokenProvider.notifier).update((state) => data.token);
    }, failure: (errorHandle) {
      state = AsyncValue.error(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      );
    });
  }
}
