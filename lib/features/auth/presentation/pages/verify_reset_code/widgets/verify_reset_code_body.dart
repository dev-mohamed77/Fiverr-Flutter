import 'package:fiverr/core/components/app_button.dart';
import 'package:fiverr/core/components/loading_linear_progress_custom.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/manager/dialog/dialog_custom.dart';
import 'package:fiverr/core/manager/router/routes.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/auth/presentation/manager/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyResetCodeBody extends ConsumerStatefulWidget {
  const VerifyResetCodeBody({super.key});

  @override
  ConsumerState<VerifyResetCodeBody> createState() =>
      _VerifyResetCodeBodyState();
}

class _VerifyResetCodeBodyState extends ConsumerState<VerifyResetCodeBody> {
  late TextEditingController _resetCodeController;

  @override
  void initState() {
    _resetCodeController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _resetCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final verifyResetCode = ref.watch(verifyResetCodeUseCaseProvider);
    ref.listen(
      verifyResetCodeUseCaseProvider,
      (previous, next) {
        next.maybeWhen(
          orElse: () {},
          data: (data) {
            DialogCustom.showToast(
              message: "The reset code has been verified successfully",
              color: AppColor.primaryColor,
            ).then((value) {
              context.goNamed(Routes.resetPassword);
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
      child: Column(
        children: [
          const VerticalSpacer(50),
          LoadingLinearProgress(value: verifyResetCode),
          const VerticalSpacer(50),
          PinCodeTextField(
            appContext: context,
            keyboardType: TextInputType.number,
            length: 6,
            controller: _resetCodeController,
            autoDisposeControllers: false,
            obscuringCharacter: '●',
            obscureText: true,
            blinkWhenObscuring: true,
            pinTheme: PinTheme(
              borderWidth: 2,
              activeBorderWidth: 2,
              borderRadius: BorderRadius.circular(10),
              activeColor: AppColor.primaryColor,
              selectedColor: AppColor.primaryColor,
              shape: PinCodeFieldShape.box,
            ),
          ),
          const VerticalSpacer(50),
          AppButton(
            title: "Send",
            onPressed: () {
              ref
                  .read(verifyResetCodeUseCaseProvider.notifier)
                  .execute(resetCode: _resetCodeController.text);
            },
          ),
        ],
      ),
    );
  }
}
