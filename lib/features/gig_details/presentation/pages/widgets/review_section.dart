import 'package:fiverr/core/components/async_value.dart';
import 'package:fiverr/core/components/horizontal_spacer.dart';
import 'package:fiverr/core/components/text_button_custom.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/extension/responsive_size_extensions.dart';
import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/core/manager/router/routes.dart';
import 'package:fiverr/features/gig_details/presentation/pages/widgets/container_custom.dart';
import 'package:fiverr/features/gig_details/presentation/pages/widgets/review_gig_item.dart';
import 'package:fiverr/features/gigs/domain/entity/gig_entity.dart';
import 'package:fiverr/features/reviews/presentation/manager/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ReviewSection extends ConsumerWidget {
  const ReviewSection({
    super.key,
    required this.gig,
  });

  final GigEntity gig;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviews = ref.watch(getReviewsUseCaseProvider);
    return AsyncValueWidget(
      value: reviews,
      data: (data) {
        return ContainerCustom(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RatingBar(
                    initialRating: gig.averageRating,
                    itemSize: 25,
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
                    itemPadding: const EdgeInsets.symmetric(horizontal: 1),
                    itemCount: 5,
                    onRatingUpdate: (double value) {},
                    ignoreGestures: true,
                  ),
                  const HorizontalSpacer(10),
                  Text(
                    gig.averageRating.toStringAsFixed(2),
                    style: context.bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ],
              ),
              const VerticalSpacer(25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${data?.length ?? 0} Reviews",
                    style: context.titleMedium!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButtonCustom(
                    text: "See All",
                    onClick: () {
                      ref
                          .read(getReviewsUseCaseProvider.notifier)
                          .execute(gigId: gig.id);
                      context.pushNamed(
                        Routes.reviews,
                        extra: {"length": data!.length.toString()},
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                width: context.width,
                height: context.height * 0.28,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: data?.result.length ?? 0,
                  itemBuilder: (context, index) {
                    return ReviewGigItem(
                      name: data?.result[index].user.name ?? "",
                      country: data?.result[index].user.country ?? "",
                      description: data?.result[index].description ?? "",
                      star: data?.result[index].star ?? 0,
                      createdAt: data?.result[index].createdAt ?? "",
                    );
                  },
                ),
              ),
              const VerticalSpacer(50),
            ],
          ),
        );
      },
    );
  }
}
