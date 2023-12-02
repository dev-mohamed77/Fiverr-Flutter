import 'package:fiverr/features/seller/presentation/pages/create_seller/welcome_create_seller/widgets/welcome_create_sellre_body.dart';
import 'package:flutter/material.dart';

class WelcomeCreateSellerScreen extends StatelessWidget {
  const WelcomeCreateSellerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const WelcomeCreateSellerBody(),
    );
  }
}
