import 'package:fiverr/core/service/network_service/api/api_result.dart';

abstract class IPaymentRepository {
  Future<ApiResult<void>> makePayment({
    required int amount,
    required String currency,
  });
}

abstract class IGooglePaymentRepository extends IPaymentRepository {}

abstract class IStripePaymentRepository extends IPaymentRepository {}
