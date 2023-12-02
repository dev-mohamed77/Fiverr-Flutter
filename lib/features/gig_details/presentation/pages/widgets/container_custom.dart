import 'package:fiverr/core/extension/responsive_size_extensions.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:flutter/material.dart';

class ContainerCustom extends StatelessWidget {
  const ContainerCustom({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.whiteColor,
        boxShadow: [
          BoxShadow(
            color: AppColor.greyColor,
            offset: Offset(0, 1),
            blurRadius: 1,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      width: context.width,
      padding: const EdgeInsets.all(20),
      child: child,
    );
  }
}
