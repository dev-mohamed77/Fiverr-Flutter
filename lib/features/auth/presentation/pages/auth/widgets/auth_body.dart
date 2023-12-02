import 'package:fiverr/core/components/text_button_custom.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/core/manager/dialog/dialog_custom.dart';
import 'package:fiverr/core/manager/router/routes.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/auth/presentation/manager/providers.dart';
import 'package:fiverr/features/auth/presentation/pages/widgets/auth_button.dart';
import 'package:fiverr/features/auth/presentation/pages/widgets/fiverr_image.dart';
import 'package:fiverr/features/auth/presentation/pages/signup/widgets/term_of_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class AuthBody extends ConsumerWidget {
  const AuthBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authUseCaseProvider, (previous, next) {
      next.maybeWhen(
        orElse: () {},
        data: (data) {
          DialogCustom.showToast(
            message: "SignIn Successfully",
            color: AppColor.primaryColor,
          );
          context.go(Routes.home);
        },
        error: (error, stackTrace) {
          DialogCustom.showSnackBar(
            context,
            message: error.toString(),
            color: AppColor.redColor,
          );
        },
      );
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VerticalSpacer(15),
          const FiverrImage(),
          const VerticalSpacer(15),
          Text(
            'Join Fiverr',
            style: context.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const VerticalSpacer(10),
          Text(
            "join our growing freelance community to offer your professional services, connect with customers, and get paid on Fiverr's trusted platform",
            style: context.titleMedium!.copyWith(
              height: 1.5,
            ),
          ),
          const VerticalSpacer(17),
          AuthButton(
            text: 'Continue With Facebook',
            colorIcon: AppColor.blueColor,
            icon: Icons.facebook,
            onClick: () async {
              ref.read(authUseCaseProvider.notifier).executeFaceBook();
            },
          ),
          const VerticalSpacer(17),
          AuthButton(
              text: 'Continue With Google',
              colorIcon: AppColor.redColor,
              icon: FontAwesomeIcons.google,
              onClick: () async {
                ref.read(authUseCaseProvider.notifier).executeGoogle();
              }),
          const VerticalSpacer(17),
          AuthButton(
            text: 'Sign Up With Email',
            colorIcon: AppColor.blackColor,
            icon: Icons.email_outlined,
            onClick: () {
              context.push(Routes.signUp);
            },
          ),
          const VerticalSpacer(15),
          const TermOfService(),
          const Spacer(),
          TextButtonCustom(
            text: "Sign In",
            onClick: () {
              context.push(Routes.signIn);
            },
          ),
          const VerticalSpacer(15),
        ],
      ),
    );
  }
}
