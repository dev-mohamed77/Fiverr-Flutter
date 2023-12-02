import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/gig_details/domain/repository/gig_details_repository.dart';
import 'package:fiverr/features/gigs/domain/entity/gig_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GigDetailsUseCase extends StateNotifier<AsyncValue<GigEntity?>> {
  GigDetailsUseCase(this.repo) : super(const AsyncValue.data(null));
  final IGigDetailsRepository repo;

  Future<void> execute({
    required String id,
  }) async {
    state = const AsyncValue.loading();

    final result = await repo.getGigByID(id: id);

    state = result.when(
      success: (data) => AsyncValue.data(data),
      failure: (errorHandle) => AsyncValue.error(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      ),
    );
  }
}
