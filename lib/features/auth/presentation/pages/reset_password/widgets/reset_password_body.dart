import 'package:fiverr/core/components/app_button.dart';
import 'package:fiverr/core/components/async_snapshot_builder.dart';
import 'package:fiverr/core/components/loading_linear_progress_custom.dart';
import 'package:fiverr/core/components/text_form_field_custom.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/manager/dialog/dialog_custom.dart';
import 'package:fiverr/core/manager/router/routes.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/auth/presentation/manager/email_provider.dart';
import 'package:fiverr/features/auth/presentation/manager/providers.dart';
import 'package:fiverr/features/auth/presentation/manager/reset_password_manager.dart';
import 'package:fiverr/features/auth/presentation/manager/show_password_manager.dart';
import 'package:fiverr/features/nav_bar/presentation/manager/navbar_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordBody extends ConsumerStatefulWidget {
  const ResetPasswordBody({super.key});

  @override
  ConsumerState<ResetPasswordBody> createState() => _ResetPasswordBodyState();
}

class _ResetPasswordBodyState extends ConsumerState<ResetPasswordBody> {
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late ResetPasswordButtonManager resetPasswordButtonManager;

  @override
  void initState() {
    _confirmPasswordController = TextEditingController();
    _passwordController = TextEditingController();
    resetPasswordButtonManager = ResetPasswordButtonManager();
    super.initState();
  }

  @override
  void dispose() {
    _confirmPasswordController.dispose();
    _passwordController.dispose();
    resetPasswordButtonManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isShowPass = ref.watch(showPasswordProvider);
    final resetPassword = ref.watch(resetPasswordUseCaseProvider);

    ref.listen(
      resetPasswordUseCaseProvider,
      (previous, next) {
        next.maybeWhen(
          orElse: () {},
          data: (data) {
            context.go(Routes.home);
            ref.read(navBarIndexProvider.notifier).update((state) => 0);
            ref
                .read(forgetPasswordEmailProvider.notifier)
                .update((state) => null);
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
      child: Column(
        children: [
          const VerticalSpacer(50),
          LoadingLinearProgress(value: resetPassword),
          const VerticalSpacer(50),
          TextFormFieldCustom(
            label: "Password",
            controller: _passwordController,
            obscureText: isShowPass,
            keyboardType: TextInputType.visiblePassword,
            onChanged: (value) =>
                resetPasswordButtonManager.setPassword.add(value),
            suffix: IconButton(
              onPressed: () {
                ref.read(showPasswordProvider.notifier).state = !isShowPass;
              },
              icon: isShowPass
                  ? const Icon(Icons.visibility_off_rounded)
                  : const Icon(Icons.visibility),
            ),
          ),
          const VerticalSpacer(15),
          Row(
            children: [
              Expanded(
                child: TextFormFieldCustom(
                  label: "Confirm Password",
                  obscureText: isShowPass,
                  controller: _confirmPasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (value) =>
                      resetPasswordButtonManager.setConfirmPassword.add(value),
                  suffix: AsyncSnapshotStreamBuilder(
                    stream: resetPasswordButtonManager.isShowButton,
                    onActive: (context, data) {
                      final isCheck = data ?? false;

                      return isCheck
                          ? const Icon(
                              Icons.check_circle_outline,
                              color: AppColor.primaryColor,
                            )
                          : const Icon(
                              Icons.close,
                              color: Colors.red,
                            );
                    },
                  ),
                ),
              ),
            ],
          ),
          const VerticalSpacer(50),
          AsyncSnapshotStreamBuilder(
            stream: resetPasswordButtonManager.isShowButton,
            onActive: (context, data) {
              final isShow = data ?? false;
              return AppButton(
                title: 'Reset Password',
                onPressed: isShow
                    ? () {
                        ref.read(resetPasswordUseCaseProvider.notifier).execute(
                              email: ref.watch(forgetPasswordEmailProvider)!,
                              password: _confirmPasswordController.text,
                            );
                      }
                    : null,
              );
            },
          ),
        ],
      ),
    );
  }
}
