import 'package:fiverr/features/gigs/domain/entity/gig_entity.dart';
import 'package:fiverr/features/order/presentation/pages/order_review/widgets/order_review_body.dart';
import 'package:flutter/material.dart';

class OrderReviewScreen extends StatelessWidget {
  const OrderReviewScreen({
    super.key,
    required this.gig,
    required this.sellerId,
  });

  final GigEntity gig;
  final String sellerId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Order Review",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: OrderReviewBody(
        gig: gig,
        sellerId: sellerId,
      ),
    );
  }
}
