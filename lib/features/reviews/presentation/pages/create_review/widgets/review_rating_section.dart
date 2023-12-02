import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/features/reviews/presentation/manager/select_add_review_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewRatingSection extends ConsumerWidget {
  const ReviewRatingSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Rating"),
        const VerticalSpacer(5),
        RatingBar(
          initialRating: 3,
          direction: Axis.horizontal,
          itemCount: 5,
          maxRating: 5,
          ratingWidget: RatingWidget(
            full: const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            half: const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            empty: const Icon(
              Icons.star,
              color: Colors.grey,
            ),
          ),
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          onRatingUpdate: (rating) {
            ref
                .read(reviewRatingProvider.notifier)
                .update((state) => rating.toInt());
          },
        ),
      ],
    );
  }
}
