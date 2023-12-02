import 'package:dropdown_search/dropdown_search.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/features/explore/domain/entity/category_entity.dart';
import 'package:fiverr/features/explore/presentation/manager/providers.dart';
import 'package:fiverr/features/gigs/presentation/manager/select_category_and_sucategory_provider.dart';
import 'package:fiverr/features/subcategory/presentation/manager/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectCategoryAndSubCategorySection extends ConsumerWidget {
  const SelectCategoryAndSubCategorySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subCategory = ref.watch(getSubCategoriesByCategoryIDUseCaseProvider);
    final category = ref.watch(getCategoriesUseCaseProvider);
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Category"),
            const VerticalSpacer(5),
            DropdownSearch<CategoryEntity>(
              items: category.asData?.value ?? [],
              itemAsString: (item) {
                return item.name;
              },
              onChanged: (value) {
                ref
                    .read(getSubCategoriesByCategoryIDUseCaseProvider.notifier)
                    .execute(value!.id);
                ref
                    .read(selectGigCategoryProvider.notifier)
                    .update((state) => value);
              },
            ),
          ],
        ),
        const VerticalSpacer(15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("SubCategory"),
            const VerticalSpacer(5),
            DropdownSearch(
              items: subCategory.asData?.value ?? [],
              itemAsString: (item) {
                return item.name;
              },
              onChanged: (value) {
                ref
                    .read(selectGigSubCategoryProvider.notifier)
                    .update((state) => value);
              },
            ),
          ],
        ),
      ],
    );
  }
}
