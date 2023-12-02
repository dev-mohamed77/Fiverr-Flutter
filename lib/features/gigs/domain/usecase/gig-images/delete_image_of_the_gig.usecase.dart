import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/gigs/domain/repository/gig_images_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeleteImageOfTheGigUseCase extends StateNotifier<AsyncValue<String?>> {
  DeleteImageOfTheGigUseCase(this.repo) : super(const AsyncValue.data(null));
  final GigImagesRepository repo;

  Future<void> execute({required String imageId, required String gigId}) async {
    state = const AsyncValue.loading();

    final result = await repo.deleteImageOfTheGig(imageId, gigId);

    state = result.when(
      success: (data) => AsyncValue.data(data),
      failure: (errorHandle) => AsyncValue.error(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      ),
    );
  }
}
