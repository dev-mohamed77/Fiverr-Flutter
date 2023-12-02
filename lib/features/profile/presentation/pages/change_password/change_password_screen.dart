import 'package:fiverr/features/profile/presentation/pages/change_password/widgets/change_password_body.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Change Password",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: const ChangePasswordBody(),
    );
  }
}
