import 'package:fiverr/features/profile/presentation/pages/account/widgets/account_body.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Account",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: const AccountBody(),
    );
  }
}
