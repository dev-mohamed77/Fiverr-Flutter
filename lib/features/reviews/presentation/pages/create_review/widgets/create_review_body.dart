import 'package:fiverr/core/components/loading_linear_progress_custom.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/manager/dialog/dialog_custom.dart';
import 'package:fiverr/core/manager/router/routes.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/reviews/presentation/manager/providers.dart';
import 'package:fiverr/features/reviews/presentation/manager/select_add_review_provider.dart';
import 'package:fiverr/features/reviews/presentation/pages/create_review/widgets/review_button_section.dart';
import 'package:fiverr/features/reviews/presentation/pages/create_review/widgets/review_description_section.dart';
import 'package:fiverr/features/reviews/presentation/pages/create_review/widgets/review_rating_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class CreateReviewBody extends ConsumerWidget {
  const CreateReviewBody({super.key, required this.gigID});

  final String gigID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createReview = ref.watch(createReviewsUseCaseProvider);

    ref.listen(
      createReviewsUseCaseProvider,
      (previous, next) {
        next.maybeWhen(
          orElse: () {},
          data: (data) {
            DialogCustom.showToast(
              message: "The review has been created successfully",
              color: AppColor.primaryColor,
              gravity: ToastGravity.TOP,
            );
            ref.read(getReviewsUseCaseProvider.notifier).execute(gigId: gigID);
            ref
                .read(reviewDescriptionProvider.notifier)
                .update((state) => null);
            ref.read(reviewRatingProvider.notifier).update((state) => null);
            context.pushNamed(Routes.reviews, extra: {"length": "-"});
          },
          error: (error, stackTrace) {
            DialogCustom.showToast(
              message: error.toString(),
              color: AppColor.redColor,
              gravity: ToastGravity.TOP,
            );
          },
        );
      },
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalSpacer(7),
                  LoadingLinearProgress(value: createReview),
                  const VerticalSpacer(7),
                  const ReviewDescriptionSection(),
                  const VerticalSpacer(30),
                  const VerticalSpacer(30),
                  const ReviewRatingSection()
                ],
              ),
            ),
          ),
          ReviewButtonSection(
            gigId: gigID,
          ),
        ],
      ),
    );
  }
}
