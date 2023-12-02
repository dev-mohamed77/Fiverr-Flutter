import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/features/subcategory/presentation/manager/select_subcategory_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubCategoryTitleSection extends ConsumerWidget {
  const SubCategoryTitleSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final suCategory = ref.watch(selectSubCategoryProvider);

    return Text(
      suCategory?.name ?? "",
      style: context.titleLarge!.copyWith(fontWeight: FontWeight.bold),
    );
  }
}
