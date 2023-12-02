import 'package:fiverr/core/components/horizontal_spacer.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/extension/responsive_size_extensions.dart';
import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/gig_details/presentation/pages/widgets/container_custom.dart';
import 'package:fiverr/features/reviews/domain/entity/review_entity.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({super.key, required this.review});

  final ReviewDataEntity review;

  @override
  Widget build(BuildContext context) {
    return ContainerCustom(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(context.width / 2),
                  color: AppColor.orangeColor,
                ),
                child: Text(
                  "M",
                  style: context.titleMedium!.copyWith(
                    color: AppColor.whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const HorizontalSpacer(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.user.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    review.user.country,
                    style:
                        context.bodyMedium!.copyWith(color: AppColor.greyColor),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    size: 16,
                    color: Colors.amber,
                  ),
                  const HorizontalSpacer(5),
                  Text(
                    "${review.star}",
                    style: context.bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          const VerticalSpacer(20),
          Text(
            format(DateTime.parse(review.createdAt)),
            style: context.bodySmall!.copyWith(color: AppColor.greyColor),
          ),
          const VerticalSpacer(10),
          Text(
            review.description,
            style: context.titleSmall!,
          ),
        ],
      ),
    );
  }
}
