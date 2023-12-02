import 'package:fiverr/features/welcome/presentation/pages/widgets/welcome_body.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WelcomeBody(),
    );
  }
}
