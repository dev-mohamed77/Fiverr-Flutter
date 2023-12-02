import 'package:fiverr/core/components/horizontal_spacer.dart';
import 'package:fiverr/core/extension/responsive_size_extensions.dart';
import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:flutter/material.dart';

class SearchSection extends StatelessWidget {
  const SearchSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        height: 50,
        width: context.width,
        padding: const EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              color: AppColor.greyColor,
              offset: Offset(1, 1),
              blurRadius: 2,
              spreadRadius: 0.5,
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(
              Icons.search,
              color: AppColor.greyColor,
            ),
            const HorizontalSpacer(10),
            Text(
              "Search Service",
              style: context.bodyMedium!.copyWith(
                color: AppColor.greyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
