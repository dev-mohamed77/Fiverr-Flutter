import 'package:fiverr/core/extension/responsive_size_extensions.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:flutter/material.dart';

class ImageContainerCustom extends StatelessWidget {
  const ImageContainerCustom(
      {super.key, required this.child, required this.onClick});

  final Widget child;

  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: context.width / 4.6,
        height: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.greyColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(15),
        ),
        child: child,
      ),
    );
  }
}
