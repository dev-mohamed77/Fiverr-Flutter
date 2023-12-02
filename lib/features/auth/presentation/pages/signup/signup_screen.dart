import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/auth/presentation/pages/signup/widgets/sign_up_body.dart';
import 'package:fiverr/features/auth/presentation/pages/widgets/title_text_appbar.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColor.blackColor),
        title: const TitleTextAppBar(title: "Sign Up With Email"),
      ),
      body: const SignUpBody(),
    );
  }
}
