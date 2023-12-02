import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/core/manager/dialog/dialog_custom.dart';
import 'package:fiverr/core/manager/router/routes.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/auth/presentation/manager/providers.dart';
import 'package:fiverr/features/auth/presentation/pages/signin/widgets/signin_with_emai_password.dart';
import 'package:fiverr/features/auth/presentation/pages/signin/widgets/social_auth_section.dart';
import 'package:fiverr/features/auth/presentation/pages/widgets/fiverr_image.dart';
import 'package:fiverr/features/nav_bar/presentation/manager/navbar_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignInBody extends ConsumerWidget {
  const SignInBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signIn = ref.watch(signInUseCaseProvider);

    ref.listen(signInUseCaseProvider, (previous, next) {
      next.maybeWhen(
        orElse: () {},
        data: (data) {
          DialogCustom.showSnackBar(
            context,
            message: "Sign up Successfully",
            color: AppColor.primaryColor,
          ).then((_) {
            ref.read(navBarIndexProvider.notifier).update((state) => 0);
            context.go(Routes.home);
          });
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const VerticalSpacer(50),
            signIn.isLoading
                ? const LinearProgressIndicator(
                    color: AppColor.primaryColor,
                  )
                : const SizedBox.shrink(),
            const VerticalSpacer(50),
            const FiverrImage(),
            const VerticalSpacer(15),
            Text(
              "Welcome Back",
              style: context.titleLarge,
            ),
            const VerticalSpacer(15),
            Text(
              "Sign in to Fiverr to pick up exactly where you left off.",
              style: context.titleMedium!.copyWith(
                height: 1.5,
              ),
            ),
            const VerticalSpacer(25),
            const SocialAuthSection(),
            const VerticalSpacer(15),
            SizedBox(
              width: double.infinity,
              child: Text(
                "or sign in with email",
                textAlign: TextAlign.center,
                style: context.titleMedium,
              ),
            ),
            const VerticalSpacer(15),
            const SignInWithEmailAndPasswordSection(),
          ],
        ),
      ),
    );
  }
}
