// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fiverr/core/service/network_service/api/api_result.dart';
import 'package:fiverr/features/order/data/data_source/payment_remote_data_source.dart';
import 'package:fiverr/features/order/domain/repository/payment_repository.dart';

class StripePaymentRepositoryImp implements IStripePaymentRepository {
  final IStripePaymentDataSource stripePaymentDataSource;

  StripePaymentRepositoryImp({
    required this.stripePaymentDataSource,
  });

  @override
  Future<ApiResult<void>> makePayment({
    required int amount,
    required String currency,
  }) async {
    try {
      String clientSecret = await stripePaymentDataSource.getClientSecret(
        amount: (amount * 100).toString(),
        currency: currency,
      );
      await _initializePaymentSheet(clientSecret);

      final present = await _presentPaymentSheet();

      return ApiResult.success(present);
    } catch (error) {
      print("error ============>> $error");
      if (error is StripeException) {
        return ApiResult.failure(ErrorHandle.badRequest(error.toString()));
      }

      return ApiResult.failure(ErrorHandle.getDioException(error));
    }
  }

  Future<void> _initializePaymentSheet(String clientSecret) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: "Basel",
      ),
    );
  }

  Future<void> _presentPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }
}
