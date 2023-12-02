import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/features/gigs/domain/entity/gig_entity.dart';
import 'package:fiverr/features/order/presentation/pages/order_review/widgets/order_button.dart';
import 'package:fiverr/features/order/presentation/pages/order_review/widgets/payment_method_widget.dart';
import 'package:fiverr/features/order/presentation/pages/order_review/widgets/payment_price.dart';
import 'package:flutter/material.dart';

class OrderReviewBody extends StatelessWidget {
  const OrderReviewBody({super.key, required this.gig, required this.sellerId});

  final GigEntity gig;
  final String sellerId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const VerticalSpacer(50),
                  const PaymentMethodWidget(),
                  const VerticalSpacer(10),
                  const Divider(),
                  const VerticalSpacer(10),
                  PaymentPrice(
                    gig: gig,
                  )
                ],
              ),
            ),
          ),
          OrderButton(
            gig: gig,
            sellerId: sellerId,
          )
        ],
      ),
    );
  }
}
