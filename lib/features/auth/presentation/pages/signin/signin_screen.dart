import 'package:fiverr/features/auth/presentation/pages/signin/widgets/sign_in_body.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SignInBody(),
    );
  }
}
