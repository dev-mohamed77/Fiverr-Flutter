import 'package:fiverr/features/gigs/domain/entity/gig_entity.dart';
import 'package:fiverr/features/gigs/presentation/pages/update_gig_screen/widgets/update_gig_body.dart';
import 'package:flutter/material.dart';

class UpdateGigScreen extends StatelessWidget {
  const UpdateGigScreen({super.key, required this.gig});

  final GigEntity gig;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: UpdateGigBody(
        gig: gig,
      ),
    );
  }
}
