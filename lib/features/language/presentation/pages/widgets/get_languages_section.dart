import 'package:fiverr/core/components/async_value.dart';
import 'package:fiverr/core/manager/dialog/dialog_custom.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/language/presentation/manager/providers.dart';
import 'package:fiverr/features/language/presentation/manager/select_language_and_level.dart';
import 'package:fiverr/features/language/presentation/pages/widgets/language_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SellerLanguagesSection extends ConsumerStatefulWidget {
  const SellerLanguagesSection({
    super.key,
  });

  @override
  ConsumerState<SellerLanguagesSection> createState() =>
      _SellerLanguagesSectionState();
}

class _SellerLanguagesSectionState
    extends ConsumerState<SellerLanguagesSection> {
  @override
  Widget build(BuildContext context) {
    final languages = ref.watch(getLanguageBySellerIdUseCaseProvider);
    ref.listen(deleteLanguageUseCaseProvider, (previous, next) {
      next.maybeWhen(
        orElse: () {},
        data: (data) {
          DialogCustom.showToast(
            message: data!,
            color: AppColor.primaryColor,
            gravity: ToastGravity.TOP,
          );

          final language = ref.watch(selectDeleteLanguageProvider);
          if (language != null) {
            ref
                .read(getLanguageBySellerIdUseCaseProvider.notifier)
                .deleteLanguage(language);

            ref
                .read(selectDeleteLanguageProvider.notifier)
                .update((state) => null);
          }
        },
        error: (error, stackTrace) {
          DialogCustom.showToast(
            message: error.toString(),
            color: AppColor.redColor,
          );
        },
      );
    });
    return AsyncValueWidget(
      value: languages,
      data: (data) {
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: data!.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return LanguageItem(
              language: data[index],
            );
          },
        );
      },
    );
  }
}
