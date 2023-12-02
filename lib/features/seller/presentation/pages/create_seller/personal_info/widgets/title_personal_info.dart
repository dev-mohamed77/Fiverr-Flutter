import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:flutter/material.dart';

class TitlePersonalInfoSection extends StatelessWidget {
  const TitlePersonalInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Personal Info",
          style: context.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
        const VerticalSpacer(20),
        Text(
          "Tell us a bit about yourself. This information will appear on your public profile, so that potential buyers can get to know you better",
          style: context.titleSmall!.copyWith(color: AppColor.greyColor),
        ),
      ],
    );
  }
}
