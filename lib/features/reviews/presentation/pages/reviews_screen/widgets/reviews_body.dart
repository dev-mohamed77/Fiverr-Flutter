import 'package:fiverr/core/components/async_value.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/features/reviews/presentation/manager/providers.dart';
import 'package:fiverr/features/reviews/presentation/pages/reviews_screen/widgets/review_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewsBody extends ConsumerWidget {
  const ReviewsBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviews = ref.watch(getReviewsUseCaseProvider);

    return AsyncValueWidget(
      value: reviews,
      data: (data) {
        return ListView.separated(
          itemCount: data!.length,
          itemBuilder: (context, index) {
            return ReviewItem(
              review: data.result[index],
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const VerticalSpacer(1);
          },
        );
      },
    );
  }
}
