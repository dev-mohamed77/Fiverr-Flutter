import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/providers/language/language_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LanguageBody extends ConsumerWidget {
  const LanguageBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(languageManagerProvider);

    return WillPopScope(
      onWillPop: () {
        ref.refresh(languageManagerProvider.notifier).init();

        return Future.value(true);
      },
      child: ListView.separated(
        itemCount: language.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              ref
                  .read(selectLanguageProvider.notifier)
                  .update((state) => language[index]);
              context.pop();
            },
            title: Text(language[index]),
            trailing: const Icon(Icons.arrow_forward_ios),
          );
        },
        separatorBuilder: (context, index) {
          return const VerticalSpacer(15);
        },
      ),
    );
  }
}
