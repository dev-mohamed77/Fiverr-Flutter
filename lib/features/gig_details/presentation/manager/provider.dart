import 'dart:async';

import 'package:fiverr/features/gig_details/domain/repository/privoder.dart';
import 'package:fiverr/features/gig_details/domain/usecase/get_gig_details_usecase.dart';
import 'package:fiverr/features/gigs/domain/entity/gig_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gigDetailsUseCaseProvider = StateNotifierProvider.autoDispose<
    GigDetailsUseCase, AsyncValue<GigEntity?>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });

  final repoImp = ref.watch(gigDetailsRepositoryProvider);

  return GigDetailsUseCase(repoImp);
});
