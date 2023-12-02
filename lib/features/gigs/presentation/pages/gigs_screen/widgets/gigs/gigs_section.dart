import 'package:fiverr/core/components/async_value.dart';
import 'package:fiverr/core/components/centered_message.dart';
import 'package:fiverr/core/components/gig_horizontal_item.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/manager/dialog/dialog_custom.dart';
import 'package:fiverr/core/manager/router/routes.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/gig_details/presentation/manager/provider.dart';
import 'package:fiverr/features/gigs/presentation/manager/providers.dart';
import 'package:fiverr/features/my_list/presentation/manager/providers.dart';
import 'package:fiverr/features/reviews/presentation/manager/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class GigsSection extends ConsumerWidget {
  const GigsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gigs = ref.watch(getGigsBySubCategoryIdUseCaseProvider);
    final gigsNotifier =
        ref.watch(getGigsBySubCategoryIdUseCaseProvider.notifier);

    ref.listen(
      addFavoriteUseCaseProvider,
      (previous, next) {
        next.maybeWhen(
          orElse: () {},
          data: (data) {
            DialogCustom.showToast(
              message: "It has been successfully added to favorites",
              color: AppColor.primaryColor,
            );
          },
          error: (error, stackTrace) {
            DialogCustom.showToast(
              message: error.toString(),
              color: AppColor.redColor,
            );
          },
        );
      },
    );

    return AsyncValueWidget(
      value: gigs,
      data: (data) {
        if (data!.isEmpty) {
          return const CenteredMessage("No Gigs Yet.");
        }
        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            if (data.length == index) {
              if (!gigsNotifier.noItemMore) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColor.primaryColor,
                  ),
                );
              } else if (gigsNotifier.noItemMore) {
                return const CenteredMessage('No more items');
              } else {
                return const SizedBox.shrink();
              }
            }

            return GigHorizontalItem(
              gig: data[index],
              onClick: () {
                Future.wait([
                  ref.read(getReviewsUseCaseProvider.notifier).execute(
                        gigId: data[index].id,
                        limit: "10",
                        sort: "DESC",
                      ),
                  ref
                      .read(gigDetailsUseCaseProvider.notifier)
                      .execute(id: data[index].id),
                ]);

                context.push(Routes.gigDetails);
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const VerticalSpacer(15);
          },
        );
      },
    );
  }
}
