import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/nav_bar/presentation/manager/navbar_manager.dart';
import 'package:fiverr/features/nav_bar/presentation/pages/widgets/bottom_navigation_bar_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavBarScreen extends ConsumerWidget {
  const NavBarScreen({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navBarIndex = ref.watch(navBarIndexProvider.notifier).state;
    return Scaffold(
      extendBodyBehindAppBar: navBarIndex == 4 ? true : false,
      appBar: _appBar(ref: ref),
      body: child,
      bottomNavigationBar: const BottomNavigationBarCustom(),
    );
  }

  PreferredSizeWidget _appBar({
    required WidgetRef ref,
  }) {
    final navBarIndex = ref.watch(navBarIndexProvider.notifier).state;

    switch (navBarIndex) {
      case 0:
        return _appBarWidget(
          title: "Fiverr",
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            )
          ],
        );
      case 1:
        return _appBarWidget(
          title: "Inbox",
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.filter_2_sharp),
            )
          ],
        );
      case 2:
        return _appBarWidget(
          title: "Categories",
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            )
          ],
        );
      case 3:
        return _appBarWidget(title: "Manage Order");
      case 4:
        return AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          elevation: 0,
        );
    }

    return AppBar();
  }

  AppBar _appBarWidget({
    required String title,
    List<Widget>? actions,
  }) {
    return AppBar(
      backgroundColor: AppColor.whiteColor,
      surfaceTintColor: AppColor.whiteColor,
      elevation: 5,
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: actions,
    );
  }
}
