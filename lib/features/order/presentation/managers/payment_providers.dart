import 'dart:async';

import 'package:fiverr/features/order/domain/repository/providers.dart';
import 'package:fiverr/features/order/domain/usecase/payment/stripe_payment_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final stripePaymentUseCaseProvider = StateNotifierProvider.autoDispose<
    StripePaymentUseCase, AsyncValue<String?>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });
  final repository = ref.watch(paymentRepositoryProvider);
  return StripePaymentUseCase(repository);
});
