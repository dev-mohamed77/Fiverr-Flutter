import 'package:fiverr/features/gigs/presentation/pages/gigs_screen/widgets/gigs/gigs_body.dart';
import 'package:flutter/material.dart';

class GigsScreen extends StatelessWidget {
  const GigsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const GigsBody(),
    );
  }
}
