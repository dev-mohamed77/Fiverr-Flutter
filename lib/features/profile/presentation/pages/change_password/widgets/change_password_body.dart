import 'package:fiverr/core/components/app_button.dart';
import 'package:fiverr/core/components/async_snapshot_builder.dart';
import 'package:fiverr/core/components/text_form_field_custom.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/manager/dialog/dialog_custom.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/auth/presentation/manager/reset_password_manager.dart';
import 'package:fiverr/features/auth/presentation/manager/show_password_manager.dart';
import 'package:fiverr/features/profile/presentation/manager/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChangePasswordBody extends ConsumerStatefulWidget {
  const ChangePasswordBody({super.key});

  @override
  ConsumerState<ChangePasswordBody> createState() => _ChangePasswordBodyState();
}

class _ChangePasswordBodyState extends ConsumerState<ChangePasswordBody> {
  late TextEditingController _currentPasswordController;
  late TextEditingController _confirmPasswordController;

  late ResetPasswordButtonManager buttonManager;

  @override
  void initState() {
    _currentPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    buttonManager = ResetPasswordButtonManager();
    super.initState();
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _confirmPasswordController.dispose();
    buttonManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final changePass = ref.watch(changePasswordUseCase);
    ref.listen(changePasswordUseCase, (previous, next) {
      next.maybeWhen(
        data: (data) {
          DialogCustom.showSnackBar(
            context,
            message: "Change Password Successfully",
            color: AppColor.primaryColor,
          );
        },
        error: (error, stackTrace) {
          DialogCustom.showSnackBar(context,
              message: error.toString(), color: AppColor.redColor);
        },
        orElse: () {},
      );
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const VerticalSpacer(20),
          changePass.isLoading
              ? const Center(
                  child: LinearProgressIndicator(
                    color: AppColor.primaryColor,
                  ),
                )
              : const SizedBox.shrink(),
          const VerticalSpacer(30),
          TextFormFieldCustom(
            label: "Current Password",
            controller: _currentPasswordController,
            obscureText: ref.watch(showPasswordProvider),
            keyboardType: TextInputType.visiblePassword,
          ),
          const VerticalSpacer(20),
          TextFormFieldCustom(
            label: "New Password",
            onChanged: (data) => buttonManager.setPassword.add(data),
            obscureText: ref.watch(showPasswordProvider),
            keyboardType: TextInputType.visiblePassword,
          ),
          const VerticalSpacer(20),
          TextFormFieldCustom(
            label: "Confirm Password",
            keyboardType: TextInputType.visiblePassword,
            controller: _confirmPasswordController,
            obscureText: ref.watch(showPasswordProvider),
            onChanged: (data) => buttonManager.setConfirmPassword.add(data),
            suffix: IconButton(
              onPressed: () {
                ref
                    .read(showPasswordProvider.notifier)
                    .update((state) => !ref.watch(showPasswordProvider));
              },
              icon: ref.watch(showPasswordProvider)
                  ? const Icon(Icons.visibility_off_rounded)
                  : const Icon(Icons.visibility),
            ),
          ),
          const VerticalSpacer(40),
          AsyncSnapshotStreamBuilder(
            stream: buttonManager.isShowButton,
            onActive: (context, data) {
              final isShow = data ?? false;
              return AppButton(
                title: "Change Password",
                onPressed: isShow
                    ? () {
                        ref.read(changePasswordUseCase.notifier).execute(
                              currentPassword: _currentPasswordController.text,
                              newPassword: _confirmPasswordController.text,
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
