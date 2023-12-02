import 'package:flutter_riverpod/flutter_riverpod.dart';

enum PaymentMethodEnum {
  pay,
  stripe,
}

final paymentMethodProvider =
    StateProvider<PaymentMethodEnum>((ref) => PaymentMethodEnum.pay);
