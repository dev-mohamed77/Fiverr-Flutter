import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/occupation/domain/entity/occupation_entity.dart';
import 'package:fiverr/features/occupation/domain/repository/occupation_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateOccupationUseCase
    extends StateNotifier<AsyncValue<OccupationEntity?>> {
  CreateOccupationUseCase(this.repo) : super(const AsyncValue.data(null));

  final IOccupationRepository repo;

  Future<void> execute({
    required String sellerId,
    required String specialization,
    required String occupation,
    required String from,
    required String to,
  }) async {
    state = const AsyncValue.loading();

    final result = await repo.createOccupation(
        sellerId: sellerId,
        specialization: specialization,
        occupation: occupation,
        from: from,
        to: to);

    result.when(
      success: (data) {
        state = AsyncValue.data(data);
      },
      failure: (errorHandler) {
        state = AsyncValue.error(
          ErrorHandle.getErrorMessage(errorHandler),
          StackTrace.current,
        );
      },
    );
  }
}
