// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fiverr/features/order/domain/repository/payment_repository.dart';

class StripePaymentUseCase extends StateNotifier<AsyncValue<String?>> {
  final IStripePaymentRepository stripePaymentRepository;
  StripePaymentUseCase(this.stripePaymentRepository)
      : super(const AsyncValue.data(null));

  Future<void> execute({
    required int amount,
    required String currency,
  }) async {
    final result = await stripePaymentRepository.makePayment(
      amount: amount,
      currency: currency,
    );

    state = result.when(
      success: (data) {
        return const AsyncValue.data("Payment completed successfully");
      },
      failure: (errorHandle) {
        return AsyncValue.error(
          ErrorHandle.getErrorMessage(errorHandle),
          StackTrace.empty,
        );
      },
    );
  }
}
