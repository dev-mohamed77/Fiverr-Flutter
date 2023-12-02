import 'package:dio/dio.dart';
import 'package:fiverr/core/service/network_service/dio_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class IStripePaymentDataSource {
  Future<String> getClientSecret({
    required String amount,
    required String currency,
  });
}

class StripePaymentDataSourceImp implements IStripePaymentDataSource {
  final Ref ref;

  StripePaymentDataSourceImp(this.ref);

  @override
  Future<String> getClientSecret({
    required String amount,
    required String currency,
  }) async {
    const secretKey =
        "sk_test_51O9UqWK5xVreaiezrf0JW3vccLJd4nofvwJNA39ouayHQ1HG0YiV8qIFe1nlPXYz149HmuvMWGvnDnOrwFojXXom00yY7qyjNB";
    final dio = ref.watch(dioProvider.call("https://api.stripe.com/v1/"));

    var response = await dio.post(
      'payment_intents',
      options: Options(
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
      ),
      data: {
        'amount': amount,
        'currency': currency,
      },
    );

    return response.data["client_secret"];
  }
}
