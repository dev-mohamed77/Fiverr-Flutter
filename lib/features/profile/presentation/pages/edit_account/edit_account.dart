import 'package:fiverr/features/profile/presentation/pages/edit_account/widgets/edit_account_body.dart';
import 'package:flutter/material.dart';

class EditAccountScreen extends StatelessWidget {
  const EditAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Account",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const EditAccountBody(),
    );
  }
}
