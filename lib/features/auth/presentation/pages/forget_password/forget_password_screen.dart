import 'package:fiverr/features/auth/presentation/pages/forget_password/widgets/forget_password_body.dart';
import 'package:fiverr/features/auth/presentation/pages/widgets/title_text_appbar.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TitleTextAppBar(title: "Forget Password"),
      ),
      body: const ForgetPasswordBody(),
    );
  }
}
