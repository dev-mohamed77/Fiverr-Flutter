import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/features/gig_details/presentation/pages/widgets/container_custom.dart';
import 'package:flutter/material.dart';

class TitleAndDescriptionSection extends StatelessWidget {
  const TitleAndDescriptionSection(
      {super.key, required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return ContainerCustom(
      child: Column(
        children: [
          Text(
            title,
            style: context.titleLarge!.copyWith(fontWeight: FontWeight.bold),
          ),
          const VerticalSpacer(15),
          Text(
            description,
            style: context.bodyMedium,
          ),
        ],
      ),
    );
  }
}
