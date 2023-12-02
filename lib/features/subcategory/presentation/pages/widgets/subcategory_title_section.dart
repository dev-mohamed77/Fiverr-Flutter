import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/features/explore/presentation/manager/select_category_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryTitleSection extends ConsumerWidget {
  const CategoryTitleSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.watch(selectCategoryProvider);
    return Column(
      children: [
        Image.network(
          category?.src ?? "",
          width: 50,
          fit: BoxFit.cover,
        ),
        const VerticalSpacer(15),
        Text(
          category?.name ?? "",
          style: context.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
