import 'package:fiverr/core/extension/responsive_size_extensions.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/auth/presentation/manager/providers.dart';
import 'package:fiverr/features/auth/presentation/pages/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialAuthSection extends ConsumerWidget {
  const SocialAuthSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: context.width / 2.4,
          child: AuthButton(
            text: "Facebook",
            icon: Icons.facebook,
            colorIcon: AppColor.blueColor,
            onClick: () {
              ref.read(signInUseCaseProvider.notifier).executeFaceBook();
            },
          ),
        ),
        SizedBox(
          width: context.width / 2.4,
          child: AuthButton(
            text: "google",
            icon: FontAwesomeIcons.google,
            colorIcon: AppColor.redColor,
            onClick: () {
              ref.read(signInUseCaseProvider.notifier).executeGoogle();
            },
          ),
        ),
      ],
    );
  }
}
