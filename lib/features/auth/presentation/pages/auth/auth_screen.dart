import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/auth/presentation/pages/auth/widgets/auth_body.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColor.blackColor),
        elevation: 0,
      ),
      body: const AuthBody(),
    );
  }
}
