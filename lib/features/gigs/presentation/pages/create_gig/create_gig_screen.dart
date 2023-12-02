import 'package:fiverr/features/gigs/presentation/pages/create_gig/widgets/create_gig_body.dart';
import 'package:flutter/material.dart';

class CreateGigScreen extends StatelessWidget {
  const CreateGigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const CreateGigBody(),
    );
  }
}
