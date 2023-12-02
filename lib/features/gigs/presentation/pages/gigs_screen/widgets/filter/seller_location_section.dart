import 'package:fiverr/core/components/horizontal_spacer.dart';
import 'package:fiverr/core/components/text_button_custom.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/core/manager/router/routes.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/core/providers/country/country_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SellerLocationSection extends ConsumerWidget {
  const SellerLocationSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final country = ref.watch(countriesManagerProvider);
    final selectCountry = ref.watch(selectCountryProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Seller Location",
          style: context.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        const VerticalSpacer(10),
        Wrap(
          children: country
              .sublist(
                  0,
                  country.length > 5
                      ? 5
                      : country.isEmpty
                          ? 0
                          : country.length - 1)
              .expand((
                e,
              ) =>
                  [
                    InputChip(
                      label: Text(e),
                      showCheckmark: false,
                      onSelected: (val) {
                        if (selectCountry == e.toString()) {
                          ref
                              .read(selectCountryProvider.notifier)
                              .update((state) => state = null);
                        } else {
                          ref
                              .read(selectCountryProvider.notifier)
                              .update((state) => state = e.toString());
                        }
                      },
                      selected: selectCountry == e.toString(),
                      selectedColor: AppColor.primaryColor.withOpacity(0.5),
                      side: BorderSide(
                        color: selectCountry == e.toString()
                            ? AppColor.primaryColor
                            : AppColor.blackColor,
                      ),
                      labelStyle: TextStyle(
                        color: selectCountry == e.toString()
                            ? AppColor.whiteColor
                            : AppColor.blackColor,
                      ),
                    ),
                    const HorizontalSpacer(10)
                  ])
              .toList(),
        ),
        const VerticalSpacer(5),
        TextButtonCustom(
          text: "+${country.length - 5} more ...",
          onClick: () {
            context.push(Routes.country);
          },
        ),
      ],
    );
  }
}
