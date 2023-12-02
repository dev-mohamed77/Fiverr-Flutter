import 'package:fiverr/core/components/app_button.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/extension/responsive_size_extensions.dart';
import 'package:fiverr/core/providers/country/country_provider.dart';
import 'package:fiverr/core/providers/language/language_providers.dart';
import 'package:fiverr/features/gigs/presentation/manager/delivery_time_filter.dart';
import 'package:fiverr/features/gigs/presentation/manager/price_range_manager.dart';
import 'package:fiverr/features/gigs/presentation/manager/providers.dart';
import 'package:fiverr/features/gigs/presentation/pages/gigs_screen/widgets/filter/delivery_time_section.dart';
import 'package:fiverr/features/gigs/presentation/pages/gigs_screen/widgets/filter/price_range_section.dart';
import 'package:fiverr/features/gigs/presentation/pages/gigs_screen/widgets/filter/seller_location_section.dart';
import 'package:fiverr/features/gigs/presentation/pages/gigs_screen/widgets/filter/seller_speak_section.dart';
import 'package:fiverr/features/subcategory/presentation/manager/select_subcategory_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FilterBody extends ConsumerWidget {
  const FilterBody({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return WillPopScope(
      onWillPop: () {
        ref.read(selectCountryProvider.notifier).update((state) => null);
        ref
            .read(selectDeliveryTimeFilterProvider.notifier)
            .update((state) => null);
        ref.read(selectLanguageProvider.notifier).update((state) => null);
        ref.read(minPriceProvider.notifier).update((state) => null);
        ref.read(maxPriceProvider.notifier).update((state) => null);

        return Future.value(true);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            const Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DeliveryTimeSection(),
                    VerticalSpacer(30),
                    SellerLocationSection(),
                    VerticalSpacer(30),
                    SellerSpeakSection(),
                    VerticalSpacer(30),
                    PriceRangeSection(),
                    VerticalSpacer(30),
                  ],
                ),
              ),
            ),
            Container(
              width: context.width,
              height: context.height * 0.09,
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Consumer(
                builder: (BuildContext context, WidgetRef ref, _) {
                  final selectDeliveryTime =
                      ref.watch(selectDeliveryTimeFilterProvider);
                  final selectCountry = ref.watch(selectCountryProvider);
                  final selectLanguage = ref.watch(selectLanguageProvider);
                  final minPrice = ref.watch(minPriceProvider);
                  final maxPrice = ref.watch(maxPriceProvider);
                  final selectSubCategory =
                      ref.watch(selectSubCategoryProvider);
                  return AppButton(
                    title: "Show Result",
                    onPressed: () {
                      ref
                          .read(getGigsBySubCategoryIdUseCaseProvider.notifier)
                          .execute(
                            selectSubCategory!.id,
                            country: selectCountry,
                            language: selectLanguage,
                            deliveryTime: selectDeliveryTime,
                            maxPrice: maxPrice,
                            minPrice: minPrice,
                          );

                      context.pop();
                      ref
                          .read(selectCountryProvider.notifier)
                          .update((state) => null);
                      ref
                          .read(selectDeliveryTimeFilterProvider.notifier)
                          .update((state) => null);
                      ref
                          .read(selectLanguageProvider.notifier)
                          .update((state) => null);
                      ref
                          .read(minPriceProvider.notifier)
                          .update((state) => null);
                      ref
                          .read(minPriceProvider.notifier)
                          .update((state) => null);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
