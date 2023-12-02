import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/manager/router/routes.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/core/providers/token/token_provider.dart';
import 'package:fiverr/core/providers/user/user_provider.dart';
import 'package:fiverr/features/auth/data/data_source/local_data_source.dart/provider.dart';
import 'package:fiverr/features/profile/presentation/manager/account_data_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AccountBody extends StatelessWidget {
  const AccountBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          UserInformationSection(),
          VerticalSpacer(20),
          UserSection(),
        ],
      ),
    );
  }
}

class UserSection extends ConsumerWidget {
  const UserSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountData = ref.watch(accountDataProvider);

    return SizedBox(
      width: double.infinity,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: accountData.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              switch (accountData[index]["title"] as String) {
                case "Edit Account":
                  context.pushNamed(Routes.editAccount);
                case "Change Password":
                  context.pushNamed(Routes.changePassword);
                case "Logout":
                  context.go(Routes.auth);
                  ref.read(authLocalDataSourceProvider).deleteToken();
                  ref.read(userProvider.notifier).update((state) => null);
                  ref.read(tokenProvider.notifier).update((state) => null);
              }
            },
            title: Text(
              accountData[index]["title"] as String,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: accountData[index]["title"] == "Logout"
                    ? AppColor.redColor
                    : AppColor.blackColor,
              ),
            ),
            tileColor: Colors.white,
            leading: Icon(
              accountData[index]["icon"] as IconData,
              color: accountData[index]["title"] == "Logout"
                  ? AppColor.redColor
                  : AppColor.blackColor,
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const VerticalSpacer(5);
        },
      ),
    );
  }
}

class UserInformationSection extends ConsumerWidget {
  const UserInformationSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          _listTileCustom(title: user?.name ?? "", subTitle: 'Full Name'),
          const VerticalSpacer(3),
          _listTileCustom(title: user?.email ?? "", subTitle: 'Email'),
          const VerticalSpacer(3),
          _listTileCustom(title: user?.gender ?? "", subTitle: 'Gender'),
          const VerticalSpacer(3),
          _listTileCustom(title: user?.phone ?? "", subTitle: 'Phone'),
          const VerticalSpacer(3),
          _listTileCustom(title: "${user?.age ?? ""}", subTitle: 'Age'),
          const VerticalSpacer(3),
          _listTileCustom(title: user?.country ?? "", subTitle: 'Country'),
        ],
      ),
    );
  }

  Widget _listTileCustom({
    required String title,
    required String subTitle,
  }) {
    return ListTile(
      tileColor: Colors.white,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(subTitle),
    );
  }
}
