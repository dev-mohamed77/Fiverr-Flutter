import 'package:fiverr/core/components/horizontal_spacer.dart';
import 'package:fiverr/core/components/text_button_custom.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/core/manager/router/routes.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/core/providers/language/language_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SellerSpeakSection extends ConsumerWidget {
  const SellerSpeakSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(languageManagerProvider);
    final selectLanguage = ref.watch(selectLanguageProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Seller speaks",
          style: context.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        const VerticalSpacer(10),
        Wrap(
          children: language
              .sublist(0, language.length > 5 ? 5 : 0)
              .expand((
                e,
              ) =>
                  [
                    InputChip(
                      label: Text(e),
                      showCheckmark: false,
                      onSelected: (val) {
                        if (selectLanguage == e.toString()) {
                          ref
                              .read(selectLanguageProvider.notifier)
                              .update((state) => state = null);
                        } else {
                          ref
                              .read(selectLanguageProvider.notifier)
                              .update((state) => state = e.toString());
                        }
                      },
                      selected: selectLanguage == e.toString(),
                      selectedColor: AppColor.primaryColor.withOpacity(0.5),
                      side: BorderSide(
                        color: selectLanguage == e.toString()
                            ? AppColor.primaryColor
                            : AppColor.blackColor,
                      ),
                      labelStyle: TextStyle(
                        color: selectLanguage == e.toString()
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
          text: "+${language.length - 5} more ...",
          onClick: () {
            context.push(Routes.language);
          },
        ),
      ],
    );
  }
}
