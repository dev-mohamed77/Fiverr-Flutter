import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/gigs/domain/entity/gig_entity.dart';
import 'package:fiverr/features/gigs/domain/repository/gigs_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetGigsByCategoryIdUseCase
    extends StateNotifier<AsyncValue<List<GigEntity>?>> {
  GetGigsByCategoryIdUseCase(this.repo) : super(const AsyncValue.data(null)) {
    execute("5d5030a9-fee6-4526-90ba-7e2ba789d17e");
  }
  final GigsRepository repo;

  Future<void> execute(
    String categoryID, {
    String? page,
    String? limit,
  }) async {
    state = const AsyncValue.loading();

    final result = await repo.getGigsByCategoryId(
      categoryID,
      page: page,
      limit: limit,
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
