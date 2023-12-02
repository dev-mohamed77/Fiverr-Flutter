import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.text,
    required this.icon,
    required this.colorIcon,
    required this.onClick,
  });
  final String text;
  final IconData icon;
  final Color colorIcon;

  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[350],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onPressed: onClick,
        icon: Icon(
          icon,
          color: colorIcon,
        ),
        label: Text(
          text,
          style: context.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
