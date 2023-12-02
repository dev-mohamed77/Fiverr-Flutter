import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:flutter/material.dart';

class TitleTextAppBar extends StatelessWidget {
  const TitleTextAppBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: AppColor.blackColor,
      ),
    );
  }
}
