import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/gigs/domain/repository/gigs_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeleteGigUseCase extends StateNotifier<AsyncValue<String?>> {
  DeleteGigUseCase(this.repo) : super(const AsyncValue.data(null));
  final GigsRepository repo;

  Future<void> execute(String gigId) async {
    state = const AsyncValue.loading();

    final result = await repo.deleteGigById(gigId);

    state = result.when(
      success: (data) => AsyncValue.data(data),
      failure: (errorHandle) => AsyncValue.error(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      ),
    );
  }
}
