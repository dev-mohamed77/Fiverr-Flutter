import 'package:fiverr/core/components/app_button.dart';
import 'package:fiverr/core/extension/responsive_size_extensions.dart';
import 'package:fiverr/core/manager/dialog/dialog_custom.dart';
import 'package:fiverr/core/manager/router/routes.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/gigs/domain/entity/gig_entity.dart';
import 'package:fiverr/features/nav_bar/presentation/manager/navbar_manager.dart';
import 'package:fiverr/features/order/domain/entity/create_order_entity.dart';
import 'package:fiverr/features/order/presentation/managers/payment_providers.dart';
import 'package:fiverr/features/order/presentation/managers/select_order.dart';
import 'package:fiverr/features/order/presentation/managers/select_payment_method.dart';
import 'package:fiverr/features/order/presentation/pages/order_review/widgets/payment_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OrderButton extends ConsumerWidget {
  const OrderButton({super.key, required this.gig, required this.sellerId});

  final GigEntity gig;
  final String sellerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _stripePaymentListen(ref, context);
    final paymentMethod = ref.watch(paymentMethodProvider);
    return Container(
      width: context.width,
      height: context.height * 0.116,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: paymentMethod == PaymentMethodEnum.pay
          ? PaymentButton()
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: AppButton(
                title: "Add Payment method",
                onPressed: () async {
                  ref.read(stripePaymentUseCaseProvider.notifier).execute(
                        amount: gig.price + (gig.price * 0.03).toInt(),
                        currency: "usd",
                      );
                },
              ),
            ),
    );
  }

  _stripePaymentListen(WidgetRef ref, BuildContext ctx) {
    ref.listen(stripePaymentUseCaseProvider, (previous, next) {
      next.maybeWhen(
        orElse: () {},
        data: (data) {
          DialogCustom.showToast(message: data!, color: AppColor.primaryColor);

          ctx.push(Routes.orderConfirm);
          ref.read(navBarIndexProvider.notifier).update((state) => 3);

          ref
              .read(selectOrderProvider.notifier)
              .update((state) => CreateOrderEntity(
                    seller: sellerId,
                    gig: gig.id,
                    deliveryTime: gig.deliveryTime,
                    payment: "credit-card",
                    description: "",
                    serviceFee: (gig.price * 0.02).toInt(),
                    subTotal: gig.price,
                  ));
        },
        error: (error, st) {
          DialogCustom.showToast(
              message: error.toString(), color: AppColor.redColor);
        },
      );
    });
  }
}
