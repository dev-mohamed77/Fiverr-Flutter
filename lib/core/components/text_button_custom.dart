import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:flutter/material.dart';

class TextButtonCustom extends StatelessWidget {
  const TextButtonCustom({
    super.key,
    required this.text,
    required this.onClick,
  });

  final String text;
  final void Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onClick,
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      child: Text(
        text,
        style: context.bodyLarge!.copyWith(
          color: AppColor.primaryColor,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
