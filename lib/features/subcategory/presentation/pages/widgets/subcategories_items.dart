import 'package:fiverr/core/components/async_value.dart';
import 'package:fiverr/core/components/centered_message.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/core/manager/router/routes.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/gigs/presentation/manager/providers.dart';
import 'package:fiverr/features/subcategory/presentation/manager/providers.dart';
import 'package:fiverr/features/subcategory/presentation/manager/select_subcategory_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SubCategoryItems extends ConsumerWidget {
  const SubCategoryItems({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subCategories =
        ref.watch(getSubCategoriesByCategoryIDUseCaseProvider);

    final subCategoriesNotifier =
        ref.watch(getSubCategoriesByCategoryIDUseCaseProvider.notifier);
    return AsyncValueWidget(
      value: subCategories,
      data: (data) {
        if (data!.isEmpty) {
          return const CenteredMessage("No Category yet.");
        }

        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: data.length + 1,
          itemBuilder: (context, index) {
            if (data.length == index) {
              if (!subCategoriesNotifier.noItemMore) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColor.primaryColor,
                  ),
                );
              } else if (subCategoriesNotifier.noItemMore) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CenteredMessage('No more items'),
                );
              } else {
                return const SizedBox.shrink();
              }
            }

            final subCategory = data[index];
            return ListTile(
              onTap: () {
                ref
                    .read(selectSubCategoryProvider.notifier)
                    .update((state) => subCategory);
                ref
                    .read(getGigsBySubCategoryIdUseCaseProvider.notifier)
                    .execute(subCategory.id);
                context.push(Routes.gigs);
              },
              title: Text(
                subCategory.name,
                style:
                    context.titleMedium!.copyWith(fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 18,
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const VerticalSpacer(5);
          },
        );
      },
    );
  }
}
