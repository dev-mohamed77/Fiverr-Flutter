import 'package:fiverr/core/components/text_button_custom.dart';
import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:flutter/material.dart';

class TermOfService extends StatelessWidget {
  const TermOfService({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Be joining, you agree to Fiverr's",
            style: context.titleMedium!.copyWith(fontSize: 15),
          ),
          TextButtonCustom(
            text: "Terms of Service",
            onClick: () {},
          ),
        ],
      ),
    );
  }
}
