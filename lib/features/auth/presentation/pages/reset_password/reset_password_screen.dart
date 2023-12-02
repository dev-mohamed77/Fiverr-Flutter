import 'package:fiverr/features/auth/presentation/pages/reset_password/widgets/reset_password_body.dart';
import 'package:fiverr/features/auth/presentation/pages/widgets/title_text_appbar.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TitleTextAppBar(title: "Reset Password"),
      ),
      body: const ResetPasswordBody(),
    );
  }
}
