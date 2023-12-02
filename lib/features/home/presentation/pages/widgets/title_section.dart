import 'package:fiverr/core/components/text_button_custom.dart';
import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/core/manager/router/routes.dart';
import 'package:fiverr/features/nav_bar/presentation/manager/navbar_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TitleSection extends ConsumerWidget {
  const TitleSection({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: context.titleLarge!.copyWith(fontWeight: FontWeight.bold),
          ),
          TextButtonCustom(
            text: "See All",
            onClick: () {
              context.go(Routes.explore);
              ref.read(navBarIndexProvider.notifier).update((state) => 2);
            },
          ),
        ],
      ),
    );
  }
}
