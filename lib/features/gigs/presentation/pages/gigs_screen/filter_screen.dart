import 'package:fiverr/core/components/text_button_custom.dart';
import 'package:fiverr/core/providers/country/country_provider.dart';
import 'package:fiverr/core/providers/language/language_providers.dart';
import 'package:fiverr/features/gigs/presentation/manager/delivery_time_filter.dart';
import 'package:fiverr/features/gigs/presentation/manager/price_range_manager.dart';
import 'package:fiverr/features/gigs/presentation/pages/gigs_screen/widgets/filter/filter_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Filter"),
        actions: [
          Consumer(
            builder: (BuildContext context, WidgetRef ref, _) {
              return TextButtonCustom(
                text: "Clear All",
                onClick: () {
                  ref
                      .read(selectCountryProvider.notifier)
                      .update((state) => null);
                  ref
                      .read(selectDeliveryTimeFilterProvider.notifier)
                      .update((state) => null);
                  ref
                      .read(selectLanguageProvider.notifier)
                      .update((state) => null);
                  ref.read(minPriceProvider.notifier).update((state) => null);
                  ref.read(maxPriceProvider.notifier).update((state) => null);
                },
              );
            },
          ),
        ],
      ),
      body: const FilterBody(),
    );
  }
}
