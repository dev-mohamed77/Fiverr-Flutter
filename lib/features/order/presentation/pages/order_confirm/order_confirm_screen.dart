import 'package:fiverr/features/order/presentation/pages/order_confirm/widgets/order_confirm_body.dart';
import 'package:flutter/material.dart';

class OrderConfirmScreen extends StatelessWidget {
  const OrderConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const OrderConfirmBody(),
    );
  }
}
