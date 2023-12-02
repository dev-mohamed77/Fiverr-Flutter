import 'package:dropdown_search/dropdown_search.dart';
import 'package:fiverr/core/components/app_button.dart';
import 'package:fiverr/core/components/horizontal_spacer.dart';
import 'package:fiverr/core/components/loading_linear_progress_custom.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/extension/responsive_size_extensions.dart';
import 'package:fiverr/core/manager/dialog/dialog_custom.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/core/providers/language/language_providers.dart';
import 'package:fiverr/features/language/presentation/manager/level_manager.dart';
import 'package:fiverr/features/language/presentation/manager/providers.dart';
import 'package:fiverr/features/language/presentation/manager/select_language_and_level.dart';
import 'package:fiverr/features/language/presentation/pages/widgets/get_languages_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SellerLanguageBody extends ConsumerWidget {
  const SellerLanguageBody({
    super.key,
    required this.sellerId,
  });

  final String sellerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createLanguage = ref.watch(createLanguageUseCaseProvider);
    _createLanguageListen(ref, context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalSpacer(15),
                  LoadingLinearProgress(value: createLanguage),
                  const VerticalSpacer(15),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownSearch<String>(
                          popupProps: const PopupProps.menu(
                            showSelectedItems: true,
                          ),
                          items: languages,
                          selectedItem:
                              ref.watch(selectSellerLanguageProvider) ??
                                  "Languages",
                          onChanged: (value) {
                            ref
                                .read(selectSellerLanguageProvider.notifier)
                                .update((state) => value);
                          },
                        ),
                      ),
                      const HorizontalSpacer(7),
                      Expanded(
                        child: DropdownSearch<String>(
                          popupProps: const PopupProps.menu(
                            showSelectedItems: true,
                          ),
                          items: levels,
                          selectedItem:
                              ref.watch(selectSellerLanguageLevelProvider) ??
                                  "Level",
                          onChanged: (value) {
                            ref
                                .read(
                                    selectSellerLanguageLevelProvider.notifier)
                                .update((state) => value);
                          },
                        ),
                      ),
                    ],
                  ),
                  const VerticalSpacer(20),
                  const SellerLanguagesSection(),
                  const VerticalSpacer(20),
                ],
              ),
            ),
          ),
          Container(
            width: context.width,
            height: context.height * 0.1,
            padding: const EdgeInsets.symmetric(vertical: 14.5),
            child: Consumer(
              builder: (BuildContext context, WidgetRef ref, _) {
                return AppButton(
                  title: "Add Language",
                  onPressed: () {
                    _createLanguage(ref: ref);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _createLanguageListen(WidgetRef ref, BuildContext ctx) {
    ref.listen(
      createLanguageUseCaseProvider,
      (previous, next) {
        next.maybeWhen(
          orElse: () {},
          data: (data) {
            DialogCustom.showToast(
              message: "The language has been created successfully",
              color: AppColor.primaryColor,
              gravity: ToastGravity.TOP,
            );
            ref
                .read(selectSellerLanguageProvider.notifier)
                .update((state) => null);
            ref
                .read(selectSellerLanguageLevelProvider.notifier)
                .update((state) => null);
            ref
                .read(getLanguageBySellerIdUseCaseProvider.notifier)
                .addLanguage(data!);
          },
          error: (error, stackTrace) {
            DialogCustom.showSnackBar(
              ctx,
              message: error.toString(),
              color: AppColor.redColor,
            );
          },
        );
      },
    );
  }

  _createLanguage({
    required WidgetRef ref,
  }) {
    final language = ref.watch(selectSellerLanguageProvider);
    final level = ref.watch(selectSellerLanguageLevelProvider);

    if (language == null || level == null) {
      DialogCustom.showToast(
        message: "You must choose the language and level",
        color: AppColor.redColor,
        gravity: ToastGravity.TOP,
      );
    } else {
      ref.read(createLanguageUseCaseProvider.notifier).execute(
            language: language,
            level: level,
            sellerId: sellerId,
          );
    }
  }
}
