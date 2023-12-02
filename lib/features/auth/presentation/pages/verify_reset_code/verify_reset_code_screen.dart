import 'package:fiverr/features/auth/presentation/pages/verify_reset_code/widgets/verify_reset_code_body.dart';
import 'package:fiverr/features/auth/presentation/pages/widgets/title_text_appbar.dart';
import 'package:flutter/material.dart';

class VerifyResetCodeScreen extends StatelessWidget {
  const VerifyResetCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TitleTextAppBar(title: "Verify Reset Code"),
      ),
      body: const VerifyResetCodeBody(),
    );
  }
}
