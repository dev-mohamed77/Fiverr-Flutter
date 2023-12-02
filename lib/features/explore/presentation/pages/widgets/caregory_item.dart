import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/core/manager/router/routes.dart';
import 'package:fiverr/features/explore/domain/entity/category_entity.dart';
import 'package:fiverr/features/explore/presentation/manager/select_category_provider.dart';
import 'package:fiverr/features/subcategory/presentation/manager/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CategoryItem extends ConsumerWidget {
  const CategoryItem({super.key, required this.category});

  final CategoryEntity category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      onTap: () {
        ref.read(selectCategoryProvider.notifier).update((state) => category);
        ref
            .read(getSubCategoriesByCategoryIDUseCaseProvider.notifier)
            .execute(category.id);
        context.pushNamed(
          Routes.subCategory,
        );
      },
      leading: Image.network(
        category.src,
        width: 35,
        fit: BoxFit.cover,
      ),

      title: Text(
        category.name,
        style: context.titleLarge!
            .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      // trailing: const Icon(Icons.arrow_forward_ios_outlined),
    );
  }
}
