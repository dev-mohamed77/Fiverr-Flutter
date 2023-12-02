import 'package:fiverr/features/reviews/presentation/pages/reviews_screen/widgets/reviews_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key, required this.reviewsCount});

  final String reviewsCount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "$reviewsCount Reviews",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Consumer(
            builder: (BuildContext context, WidgetRef ref, _) {
              return IconButton(
                onPressed: () {},
                icon: const Icon(Icons.filter),
              );
            },
          ),
        ],
      ),
      body: const ReviewsBody(),
    );
  }
}
