import 'package:fiverr/core/components/horizontal_spacer.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/extension/responsive_size_extensions.dart';
import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/gigs/presentation/manager/delivery_time_filter.dart';
import 'package:fiverr/features/gigs/presentation/manager/providers.dart';
import 'package:fiverr/features/subcategory/presentation/manager/select_subcategory_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeliveryTimeFilterSection extends ConsumerWidget {
  const DeliveryTimeFilterSection({
    required this.height,
    required this.width,
    super.key,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deliveryTimeFilter = ref.watch(deliveryTimeFilterProvider);
    final selectDeliveryTimeFilter =
        ref.watch(selectDeliveryTimeFilterProvider);
    final suCategory = ref.watch(selectSubCategoryProvider);

    return SizedBox(
      width: context.width,
      height: height * 0.81,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (context, index) {
          final data = deliveryTimeFilter[index];
          return Container(
            width: width * 0.4,
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: GestureDetector(
              onTap: () {
                ref
                    .read(selectDeliveryTimeFilterProvider.notifier)
                    .update((state) => data["title"].toString());
                switch (data["title"] as String) {
                  case "24 Hours":
                    ref
                        .read(getGigsBySubCategoryIdUseCaseProvider.notifier)
                        .execute(suCategory?.id ?? "", deliveryTime: "1");
                    break;
                  case "3 Days":
                    ref
                        .read(getGigsBySubCategoryIdUseCaseProvider.notifier)
                        .execute(suCategory?.id ?? "", deliveryTime: "3");
                    break;

                  case "7 Days":
                    ref
                        .read(getGigsBySubCategoryIdUseCaseProvider.notifier)
                        .execute(suCategory?.id ?? "", deliveryTime: "7");
                    break;
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.circular(15),
                  border: selectDeliveryTimeFilter != null &&
                          selectDeliveryTimeFilter == data["title"]
                      ? Border.all(
                          color: AppColor.primaryColor,
                          width: 1.9,
                        )
                      : null,
                  boxShadow: const [
                    BoxShadow(
                      color: AppColor.greyColor,
                      spreadRadius: 1,
                      blurRadius: 1,
                      blurStyle: BlurStyle.inner,
                      offset: Offset(0, 0),
                    ),
                    BoxShadow(
                      color: AppColor.greyColor,
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 1),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    const VerticalSpacer(10),
                    Icon(
                      data["icon"] as IconData,
                      color: AppColor.greyColor,
                      size: height * 0.25,
                    ),
                    const VerticalSpacer(15),
                    Text(
                      data["title"].toString(),
                      style: context.titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const HorizontalSpacer(10);
        },
        itemCount: deliveryTimeFilter.length,
      ),
    );
  }
}
