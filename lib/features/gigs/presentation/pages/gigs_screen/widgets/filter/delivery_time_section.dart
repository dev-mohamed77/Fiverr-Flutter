import 'package:fiverr/core/components/horizontal_spacer.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/gigs/presentation/manager/delivery_time_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeliveryTimeSection extends ConsumerWidget {
  const DeliveryTimeSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deliveryTime = ref.watch(deliveryTimeFilterProvider);
    final selectDeliveryTime = ref.watch(selectDeliveryTimeFilterProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Delivery Time",
          style: context.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        const VerticalSpacer(10),
        Wrap(
          children: deliveryTime
              .expand((
                e,
              ) =>
                  [
                    InputChip(
                      label: Text(e["title"].toString()),
                      showCheckmark: false,
                      onSelected: (val) {
                        ref
                            .read(selectDeliveryTimeFilterProvider.notifier)
                            .update((state) => state = e["title"].toString());
                      },
                      selected: selectDeliveryTime == e["title"].toString(),
                      selectedColor: AppColor.primaryColor.withOpacity(0.5),
                      side: BorderSide(
                        color: selectDeliveryTime == e["title"].toString()
                            ? AppColor.primaryColor
                            : AppColor.blackColor,
                      ),
                      labelStyle: TextStyle(
                        color: selectDeliveryTime == e["title"].toString()
                            ? AppColor.whiteColor
                            : AppColor.blackColor,
                      ),
                    ),
                    const HorizontalSpacer(10)
                  ])
              .toList(),
        ),
      ],
    );
  }
}
