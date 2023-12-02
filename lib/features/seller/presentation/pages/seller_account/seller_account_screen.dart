import 'package:fiverr/features/seller/presentation/pages/seller_account/widgets/seller_account_body.dart';
import 'package:flutter/material.dart';

class SellerAccountScreen extends StatelessWidget {
  const SellerAccountScreen({super.key, bool? isSellerLoggedUser})
      : _isSellerLoggedUser = isSellerLoggedUser ?? false;
  final bool _isSellerLoggedUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SellerAccountBody(isSellerLoggedUser: _isSellerLoggedUser),
    );
  }
}
