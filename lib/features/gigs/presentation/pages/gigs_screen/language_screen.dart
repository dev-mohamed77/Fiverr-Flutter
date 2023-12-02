import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/core/providers/language/language_providers.dart';
import 'package:fiverr/features/gigs/presentation/manager/show_search_box.dart';
import 'package:fiverr/features/gigs/presentation/pages/gigs_screen/widgets/language/language_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer(
          builder: (BuildContext context, WidgetRef ref, _) {
            final isShowSearchBox = ref.watch(isShowSearchBoxProvider);
            return isShowSearchBox
                ? TextFormField(
                    onChanged: (value) {
                      if (value.isEmpty) {
                        ref.refresh(languageManagerProvider.notifier).init();
                      }

                      ref
                          .read(languageManagerProvider.notifier)
                          .searchLanguage(value);
                    },
                    enableSuggestions: true,
                    decoration: const InputDecoration(
                      hintText: "Search",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColor.primaryColor),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColor.primaryColor),
                      ),
                    ),
                  )
                : const Text("Seller Speaks");
          },
        ),
        actions: [
          Consumer(
            builder: (BuildContext context, WidgetRef ref, _) {
              final isShowSearchBox = ref.watch(isShowSearchBoxProvider);
              return IconButton(
                onPressed: () {
                  if (isShowSearchBox) {
                    ref.refresh(languageManagerProvider.notifier).init();
                  }
                  ref
                      .read(isShowSearchBoxProvider.notifier)
                      .update((state) => !state);
                },
                icon: !isShowSearchBox
                    ? const Icon(Icons.search)
                    : const Icon(Icons.close),
              );
            },
          ),
        ],
      ),
      body: const LanguageBody(),
    );
  }
}
