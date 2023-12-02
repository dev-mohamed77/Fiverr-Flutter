import 'package:fiverr/core/components/app_button.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/core/manager/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeCreateSellerBody extends StatelessWidget {
  const WelcomeCreateSellerBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VerticalSpacer(20),
          Text(
            "Ready to start selling on Fiverr ?",
            style: context.titleLarge!.copyWith(fontWeight: FontWeight.bold),
          ),
          const VerticalSpacer(10),
          Text(
            "Here's the breakdown :",
            style: context.titleLarge!.copyWith(fontWeight: FontWeight.bold),
          ),
          const VerticalSpacer(20),
          const Divider(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _item(
                  context,
                  title: "Learning what makes a successful profile",
                  subTitle:
                      "Discover the do's and don'ts to ensure you're always on the tight track",
                  icon: Icons.book_outlined,
                ),
                const VerticalSpacer(20),
                const Divider(),
                _item(
                  context,
                  title: "Create your seller profile",
                  subTitle:
                      "Add your profile picture, description, and professional information",
                  icon: Icons.supervised_user_circle,
                ),
                const VerticalSpacer(20),
                const Divider(),
                _item(
                  context,
                  title: "publish your Gig",
                  subTitle:
                      "Create a Gig of the service you're offering and start selling instantly",
                  icon: Icons.storefront,
                ),
              ],
            ),
          ),
          const VerticalSpacer(20),
          AppButton(
            title: "Continue",
            onPressed: () {
              context.pushNamed(Routes.personalInfo);
            },
          ),
          const VerticalSpacer(20),
        ],
      ),
    );
  }

  Widget _item(
    BuildContext ctx, {
    required String title,
    required String subTitle,
    required IconData icon,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        size: 50,
      ),
      title: Text(
        title,
        style: ctx.titleMedium!.copyWith(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(subTitle),
    );
  }
}
