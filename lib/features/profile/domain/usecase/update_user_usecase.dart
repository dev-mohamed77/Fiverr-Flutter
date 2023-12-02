import 'package:fiverr/core/providers/token/token_provider.dart';
import 'package:fiverr/core/providers/user/user_provider.dart';
import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/profile/domain/entity/user_entity.dart';
import 'package:fiverr/features/profile/domain/repository/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateUserUseCase extends StateNotifier<AsyncValue<UserEntity?>> {
  UpdateUserUseCase(this.repo, this.ref) : super(const AsyncValue.data(null));

  final IUserRepository repo;
  final Ref ref;

  Future<void> execute({
    String? name,
    String? gender,
    String? phone,
    int? age,
    String? country,
  }) async {
    state = const AsyncValue.loading();

    final token = ref.watch(tokenProvider);

    final result = await repo.updateUser(
      token.toString(),
      name: name,
      gender: gender,
      phone: phone,
      age: age,
      country: country,
    );

    result.when(success: (data) {
      state = AsyncValue.data(data);
      ref.read(userProvider.notifier).update((state) => data);
    }, failure: (errorHandle) {
      state = AsyncValue.error(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      );
    });
  }
}
