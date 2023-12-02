import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:flutter/material.dart';

class CenteredMessage extends StatelessWidget {
  const CenteredMessage(
    this.title, {
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: context.titleMedium!.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
