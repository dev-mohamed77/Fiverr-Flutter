import 'package:fiverr/core/components/horizontal_spacer.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/extension/responsive_size_extensions.dart';
import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:flutter/material.dart';

class GigVerticalItm extends StatelessWidget {
  const GigVerticalItm({
    super.key,
    required this.id,
    required this.title,
    required this.price,
    required this.image,
  });

  final String id;
  final String title;
  final int price;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * 0.46,
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: AppColor.greyColor,
            offset: Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0.5,
          ),
        ],
      ),
      child: Column(
        children: [
          _imageSection(image),
          const VerticalSpacer(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
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
                      "4.9",
                      style: context.titleSmall!.copyWith(
                        color: AppColor.orangeColor,
                      ),
                    ),
                    const HorizontalSpacer(5),
                    Text(
                      "(3.8)",
                      style: context.titleSmall!.copyWith(
                        color: AppColor.orangeColor,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.favorite,
                    color: AppColor.greyColor,
                  ),
                )
              ],
            ),
          ),
          const VerticalSpacer(5),
          _titleGigSection(
            context,
            title: title,
          ),
          const VerticalSpacer(5),
          _priceSection(context, price: price)
        ],
      ),
    );
  }

  Padding _priceSection(BuildContext context, {required int price}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          const Spacer(),
          Text(
            "From",
            style: context.bodySmall,
          ),
          const HorizontalSpacer(5),
          Text(
            "\$$price",
            style: context.titleMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Padding _titleGigSection(BuildContext context, {required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        title,
        style: context.bodyMedium,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _imageSection(String src) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
      child: Image.network(
        src,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 103,
      ),
    );
  }
}
