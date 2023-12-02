import 'package:fiverr/core/components/horizontal_spacer.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/extension/responsive_size_extensions.dart';
import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/core/manager/router/routes.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/core/providers/token/token_provider.dart';
import 'package:fiverr/core/providers/user/user_provider.dart';
import 'package:fiverr/features/profile/presentation/manager/profile_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ProfileAppBarAndNameSection(),
        ProfileDataSection(),
      ],
    );
  }
}

class ProfileAppBarAndNameSection extends ConsumerWidget {
  const ProfileAppBarAndNameSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final token = ref.watch(tokenProvider);
    final user = ref.watch(userProvider);
    return Container(
      width: context.width,
      height: context.height * 0.3,
      color: token != null ? Colors.green : AppColor.greyColor,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications_none_outlined,
                    color: AppColor.whiteColor,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                const HorizontalSpacer(15),
                CircleAvatar(
                  radius: 35,
                  child: Text(
                    user?.name != null ? user!.name.substring(0, 1) : "",
                    style: context.titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                const HorizontalSpacer(15),
                Text(
                  user?.name != null ? user!.name : "Guest",
                  style: context.titleMedium!.copyWith(
                    color: AppColor.whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileDataSection extends ConsumerWidget {
  const ProfileDataSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(profileDataProvider);
    final token = ref.watch(tokenProvider);
    final user = ref.watch(userProvider);
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) {
          if (token != null && (index == 0 || index == 1)) {
            return const SizedBox.shrink();
          }
          if (token == null && (index == 2 || index == 3 || index == 4)) {
            return const SizedBox.shrink();
          }
          return ListTile(
            onTap: () {
              switch (index) {
                case 0:
                  context.push(Routes.auth);
                case 1:
                  context.push(Routes.signIn);
                case 2:
                  if (user != null) {
                    !user.isSeller
                        ? context.push(Routes.welcomeCreateSeller)
                        : context.push(Routes.sellerAccount, extra: true);
                  }

                case 3:
                  context.push(Routes.myList);
                case 4:
                  context.push(Routes.account);
              }
            },
            leading: Icon(data[index]["icon"] as IconData),
            title: Text(
              data[index]["title"].toString(),
              style: context.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            tileColor: AppColor.whiteColor,
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 20,
            ),
          );
        },
        separatorBuilder: (context, index) {
          if (token == null && (index == 3 || index == 4)) {
            return const SizedBox.shrink();
          }
          return const VerticalSpacer(10);
        },
        itemCount: data.length,
      ),
    );
  }
}
