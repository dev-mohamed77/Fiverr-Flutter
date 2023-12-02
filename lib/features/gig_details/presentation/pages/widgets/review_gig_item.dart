import 'package:fiverr/core/components/horizontal_spacer.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/extension/responsive_size_extensions.dart';
import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/core/manager/router/routes.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ReviewGigItem extends StatelessWidget {
  const ReviewGigItem({
    super.key,
    required this.name,
    required this.country,
    required this.description,
    required this.star,
    required this.createdAt,
  });

  final String name;
  final String country;
  final String description;
  final int star;
  final String createdAt;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width - 50,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Card(
        color: AppColor.whiteColor,
        surfaceTintColor: AppColor.whiteColor,
        elevation: 5,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            context.push(Routes.reviews);
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
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
                        name.substring(0, 1),
                        style: context.titleMedium!.copyWith(
                          color: AppColor.whiteColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const HorizontalSpacer(10),
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            country,
                            style: context.bodyMedium!
                                .copyWith(color: AppColor.greyColor),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const VerticalSpacer(10),
                Expanded(
                  child: Text(
                    description,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: context.bodyMedium!.copyWith(height: 1.5),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 16,
                          color: Colors.amber,
                        ),
                        const HorizontalSpacer(5),
                        Text(
                          "${star}",
                          style: context.bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Text(
                      DateFormat.MMMEd().format(DateTime.parse(createdAt)),
                      style: context.bodySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColor.greyColor,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
