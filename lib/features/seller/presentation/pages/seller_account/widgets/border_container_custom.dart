import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:flutter/material.dart';

class BorderContainerCustom extends StatelessWidget {
  const BorderContainerCustom({
    super.key,
    required this.child,
    required this.onClick,
  });

  final Widget child;
  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: 30,
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColor.primaryColor,
            width: 2.5,
          ),
        ),
        child: child,
      ),
    );
  }
}
