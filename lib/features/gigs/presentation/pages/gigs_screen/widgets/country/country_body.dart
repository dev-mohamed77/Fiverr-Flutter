import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/providers/country/country_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CountryBody extends ConsumerWidget {
  const CountryBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final country = ref.watch(countriesManagerProvider);

    return WillPopScope(
      onWillPop: () {
        ref.refresh(countriesManagerProvider.notifier).init();

        return Future.value(true);
      },
      child: ListView.separated(
        itemCount: country.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              ref
                  .read(selectCountryProvider.notifier)
                  .update((state) => country[index]);
              context.pop();
            },
            title: Text(country[index]),
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
