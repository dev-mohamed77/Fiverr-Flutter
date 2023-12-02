import 'package:fiverr/core/manager/router/routes.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/nav_bar/presentation/manager/navbar_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationBarCustom extends ConsumerWidget {
  const BottomNavigationBarCustom({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navBarIndex = ref.watch(navBarIndexProvider);

    return BottomNavigationBar(
      currentIndex: navBarIndex,
      onTap: (value) => _onTap(value, ref: ref, ctx: context),
      type: BottomNavigationBarType.shifting,
      selectedItemColor: AppColor.primaryColor,
      unselectedItemColor: AppColor.greyColor,
      items: const [
        BottomNavigationBarItem(
          label: "Home",
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          tooltip: "Home",
        ),
        BottomNavigationBarItem(
          label: "Inbox",
          icon: Icon(Icons.email),
          activeIcon: Icon(Icons.email_outlined),
          tooltip: "Inbox",
        ),
        BottomNavigationBarItem(
          label: "Explore",
          icon: Icon(Icons.search),
          activeIcon: Icon(Icons.search),
          tooltip: "Explore",
        ),
        BottomNavigationBarItem(
          label: "My List",
          icon: Icon(Icons.menu_book_rounded),
          activeIcon: Icon(Icons.menu_book_rounded),
          tooltip: "My List",
        ),
        BottomNavigationBarItem(
          label: "Profile",
          icon: Icon(Icons.person_2_sharp),
          activeIcon: Icon(Icons.person_2_sharp),
          tooltip: "Profile",
        ),
      ],
    );
  }

  _onTap(
    int index, {
    required WidgetRef ref,
    required BuildContext ctx,
  }) {
    ref.read(navBarIndexProvider.notifier).state = index;

    switch (index) {
      case 0:
        ctx.go(Routes.home);
        break;
      case 1:
        ctx.go(Routes.inbox);
        break;
      case 2:
        ctx.go(Routes.explore);
        break;
      case 3:
        ctx.go(Routes.order);
        break;
      case 4:
        ctx.go(Routes.profile);
        break;
    }
  }
}
