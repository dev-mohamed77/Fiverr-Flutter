import 'package:fiverr/features/seller/presentation/pages/create_seller/personal_info/widgets/personal_info_body.dart';
import 'package:flutter/material.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const PersonalInfoBody(),
    );
  }
}
