import 'package:fiverr/core/components/async_value.dart';
import 'package:fiverr/core/components/centered_message.dart';
import 'package:fiverr/core/components/horizontal_spacer.dart';
import 'package:fiverr/core/extension/responsive_size_extensions.dart';
import 'package:fiverr/core/manager/router/routes.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/explore/presentation/manager/providers.dart';
import 'package:fiverr/features/explore/presentation/manager/select_category_provider.dart';
import 'package:fiverr/features/home/presentation/pages/widgets/title_section.dart';
import 'package:fiverr/features/nav_bar/presentation/manager/navbar_manager.dart';
import 'package:fiverr/features/subcategory/presentation/manager/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PopularServiceSection extends ConsumerWidget {
  const PopularServiceSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catagories = ref.watch(getCategoriesUseCaseProvider);
    return AsyncValueWidget(
      value: catagories,
      data: (data) {
        if (data!.isEmpty) {
          return const CenteredMessage("No Category yet.");
        }
        return Column(
          children: [
            const TitleSection(title: "Popular Service"),
            SizedBox(
              width: context.width,
              height: context.height * 0.08,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: data.length,
                padding: const EdgeInsets.only(
                  left: 15,
                  top: 5,
                  bottom: 5,
                  right: 10,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      ref
                          .read(selectCategoryProvider.notifier)
                          .update((state) => data[index]);
                      ref
                          .read(getSubCategoriesByCategoryIDUseCaseProvider
                              .notifier)
                          .execute(data[index].id);
                      context.pushNamed(Routes.subCategory);
                      ref
                          .read(navBarIndexProvider.notifier)
                          .update((state) => 2);
                    },
                    child: Chip(
                      label: Text(data[index].name),
                      surfaceTintColor: AppColor.primaryColor,
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const HorizontalSpacer(10);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
