import 'package:fiverr/core/components/horizontal_spacer.dart';
import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/gigs/domain/entity/gig_entity.dart';
import 'package:fiverr/features/my_list/presentation/manager/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewAndFavorite extends ConsumerWidget {
  const ReviewAndFavorite({
    super.key,
    double? padding,
    bool? isFavorite,
    required this.gig,
  }) : _padding = padding ?? 8.0;

  final double _padding;
  final GigEntity gig;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.star,
                color: AppColor.orangeColor,
                size: 18,
              ),
              Text(
                gig.averageRating.toStringAsFixed(2),
                style: context.titleSmall!.copyWith(
                  color: AppColor.orangeColor,
                ),
              ),
              const HorizontalSpacer(5),
              Text(
                "(${gig.averageRating.toStringAsFixed(2)})",
                style: context.titleSmall!.copyWith(
                  color: AppColor.orangeColor,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              ref
                  .read(addFavoriteUseCaseProvider.notifier)
                  .execute(gigId: gig.id);
            },
            child: const Icon(
              Icons.favorite,
              color: AppColor.greyColor,
            ),
          )
        ],
      ),
    );
  }
}
