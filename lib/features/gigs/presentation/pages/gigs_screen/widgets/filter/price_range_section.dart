import 'package:fiverr/core/components/text_form_field_custom.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/extension/responsive_size_extensions.dart';
import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/features/gigs/presentation/manager/price_range_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PriceRangeSection extends ConsumerWidget {
  const PriceRangeSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Price range",
          style: context.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        const VerticalSpacer(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Min Price",
              style: context.bodySmall,
            ),
            Text(
              "Max Price",
              style: context.bodySmall,
            ),
          ],
        ),
        const VerticalSpacer(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: context.width / 2.25,
              child: TextFormFieldCustom(
                label: '',
                onChanged: (value) => ref
                    .read(minPriceProvider.notifier)
                    .update((state) => value),
                prefix: const Icon(Icons.currency_exchange),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(
              width: context.width / 2.25,
              child: TextFormFieldCustom(
                label: '',
                prefix: const Icon(Icons.currency_exchange),
                onChanged: (value) => ref
                    .read(maxPriceProvider.notifier)
                    .update((state) => value),
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
