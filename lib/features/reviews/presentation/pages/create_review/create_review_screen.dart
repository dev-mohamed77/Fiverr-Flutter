import 'package:fiverr/features/reviews/presentation/pages/create_review/widgets/create_review_body.dart';
import 'package:flutter/material.dart';

class CreateReviewScreen extends StatelessWidget {
  const CreateReviewScreen({super.key, required this.gigID});

  final String gigID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CreateReviewBody(
        gigID: gigID,
      ),
    );
  }
}
