import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    required this.onPressed,
    Color? color,
    double? height,
  })  : _height = height ?? 45,
        _color = color ?? AppColor.primaryColor;

  final String title;
  final void Function()? onPressed;
  final Color _color;

  final double _height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: _height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: _color,
          disabledBackgroundColor: const Color.fromARGB(255, 133, 218, 178),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
        ),
        child: Text(
          title,
          style: context.bodyLarge!.copyWith(
            color: AppColor.whiteColor,
          ),
        ),
      ),
    );
  }
}
