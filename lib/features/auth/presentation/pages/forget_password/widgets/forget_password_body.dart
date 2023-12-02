import 'package:fiverr/core/components/app_button.dart';
import 'package:fiverr/core/components/loading_linear_progress_custom.dart';
import 'package:fiverr/core/components/text_form_field_custom.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/manager/dialog/dialog_custom.dart';
import 'package:fiverr/core/manager/router/routes.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/auth/presentation/manager/email_provider.dart';
import 'package:fiverr/features/auth/presentation/manager/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ForgetPasswordBody extends ConsumerStatefulWidget {
  const ForgetPasswordBody({super.key});

  @override
  ConsumerState<ForgetPasswordBody> createState() => _ForgetPasswordBodyState();
}

class _ForgetPasswordBodyState extends ConsumerState<ForgetPasswordBody> {
  late TextEditingController _emailController;
  late GlobalKey<FormState> _key;

  @override
  void initState() {
    _emailController = TextEditingController();
    _key = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final forgetPassword = ref.watch(forgetPasswordUseCaseProvider);
    ref.listen(
      forgetPasswordUseCaseProvider,
      (previous, next) {
        next.maybeWhen(
          orElse: () {},
          data: (data) {
            DialogCustom.showToast(
              message: data.toString(),
              color: AppColor.primaryColor,
            ).then((_) {
              context.push(Routes.verifyResetCode);
              ref
                  .read(forgetPasswordEmailProvider.notifier)
                  .update((state) => _emailController.text);
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
      },
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _key,
        child: Column(
          children: [
            const VerticalSpacer(50),
            LoadingLinearProgress(value: forgetPassword),
            const VerticalSpacer(50),
            TextFormFieldCustom(
              label: "Email",
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Email is required";
                }

                return null;
              },
            ),
            const VerticalSpacer(60),
            AppButton(
              title: "Forget Password",
              onPressed: () {
                if (_key.currentState!.validate()) {
                  ref
                      .read(forgetPasswordUseCaseProvider.notifier)
                      .execute(email: _emailController.text);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
