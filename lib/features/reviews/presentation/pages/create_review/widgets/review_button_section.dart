import 'package:fiverr/core/components/app_button.dart';
import 'package:fiverr/core/extension/responsive_size_extensions.dart';
import 'package:fiverr/core/manager/dialog/dialog_custom.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/reviews/presentation/manager/providers.dart';
import 'package:fiverr/features/reviews/presentation/manager/select_add_review_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReviewButtonSection extends ConsumerWidget {
  const ReviewButtonSection({super.key, required this.gigId});

  final String gigId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final description = ref.watch(reviewDescriptionProvider);
    final rating = ref.watch(reviewRatingProvider);
    return Container(
      height: 70,
      width: context.width,
      padding: const EdgeInsets.only(bottom: 20),
      child: AppButton(
        title: "Add Review",
        onPressed: () {
          if (description == null || rating == null) {
            DialogCustom.showToast(
              message: "Description and Rating are required",
              color: AppColor.redColor,
              gravity: ToastGravity.TOP,
            );
          } else {
            ref.read(createReviewsUseCaseProvider.notifier).execute(
                  gigId: gigId,
                  star: rating,
                  description: description,
                );
          }
        },
      ),
    );
  }
}
