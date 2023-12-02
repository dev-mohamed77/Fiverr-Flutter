import 'package:fiverr/core/components/horizontal_spacer.dart';
import 'package:fiverr/core/extension/responsive_size_extensions.dart';
import 'package:fiverr/core/manager/router/routes.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/gigs/presentation/manager/filter_provider.dart';
import 'package:fiverr/features/gigs/presentation/pages/gigs_screen/widgets/gigs/delivery_time_filter_section.dart';
import 'package:fiverr/features/gigs/presentation/pages/gigs_screen/widgets/gigs/price_filter_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FilterGigWidget extends ConsumerWidget {
  const FilterGigWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(filterGigDataProvider);
    final selectFilter = ref.watch(isSelectFilterProvider);

    return SizedBox(
      width: context.width,
      height: context.height * 0.27,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            children: [
              SizedBox(
                width: context.width,
                height: constraints.maxHeight * 0.19,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: filter.length,
                  itemBuilder: (context, index) {
                    final data = filter[index];
                    return FilterChip(
                      label: Text(data),
                      selected: selectFilter == data,
                      selectedColor: AppColor.primaryColor.withOpacity(0.5),
                      avatarBorder: Border.all(color: AppColor.redColor),
                      showCheckmark: false,
                      side: BorderSide(
                        color: selectFilter == data
                            ? AppColor.primaryColor
                            : AppColor.blackColor,
                      ),
                      labelStyle: TextStyle(
                          color: selectFilter == data
                              ? AppColor.whiteColor
                              : AppColor.blackColor),
                      onSelected: (bool value) {
                        if (index == 0) {
                          context.push(Routes.filter);
                        }

                        ref
                            .read(isSelectFilterProvider.notifier)
                            .update((state) => index == 0 ? state : data);
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const HorizontalSpacer(10);
                  },
                ),
              ),
              selectFilter == "Delivery Time"
                  ? DeliveryTimeFilterSection(
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                    )
                  : const SizedBox.shrink(),
              selectFilter == "Price"
                  ? PriceFilterSection(
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                    )
                  : const SizedBox.shrink(),
            ],
          );
        },
      ),
    );
  }
}
