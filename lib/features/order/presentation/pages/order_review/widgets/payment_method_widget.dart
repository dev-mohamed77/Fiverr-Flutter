import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/order/presentation/managers/select_payment_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaymentMethodWidget extends ConsumerWidget {
  const PaymentMethodWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentMethod = ref.watch(paymentMethodProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Add payment method",
          style: context.titleLarge!
              .copyWith(fontWeight: FontWeight.bold, fontSize: 19),
        ),
        RadioListTile(
          title: Text(
            "Google Pay",
            style: context.titleMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
          value: PaymentMethodEnum.pay,
          selected: true,
          activeColor: AppColor.primaryColor,
          groupValue: paymentMethod,
          onChanged: (val) {
            ref
                .read(paymentMethodProvider.notifier)
                .update((state) => PaymentMethodEnum.pay);
          },
        ),
        RadioListTile(
          title: Text(
            "Credit or Debit Card",
            style: context.titleMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
          value: PaymentMethodEnum.stripe,
          selected: true,
          activeColor: AppColor.primaryColor,
          groupValue: paymentMethod,
          onChanged: (val) {
            ref
                .read(paymentMethodProvider.notifier)
                .update((state) => PaymentMethodEnum.stripe);
          },
        ),
      ],
    );
  }
}
