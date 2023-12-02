import 'package:fiverr/core/components/app_button.dart';
import 'package:fiverr/core/components/async_snapshot_builder.dart';
import 'package:fiverr/core/components/text_button_custom.dart';
import 'package:fiverr/core/components/text_form_field_custom.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/manager/app_manager/show_button_by_two_text_field.dart';
import 'package:fiverr/core/manager/router/routes.dart';
import 'package:fiverr/features/auth/presentation/manager/providers.dart';
import 'package:fiverr/features/auth/presentation/manager/show_password_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignInWithEmailAndPasswordSection extends ConsumerStatefulWidget {
  const SignInWithEmailAndPasswordSection({super.key});

  @override
  ConsumerState<SignInWithEmailAndPasswordSection> createState() =>
      _SignInWithEmailAndPasswordSectionState();
}

class _SignInWithEmailAndPasswordSectionState
    extends ConsumerState<SignInWithEmailAndPasswordSection> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  late ShowButtonByTwoTextField buttonManager;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    buttonManager = ShowButtonByTwoTextField();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    buttonManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        children: [
          TextFormFieldCustom(
            label: "Email",
            controller: _emailController,
            onChanged: (value) => buttonManager.setTextField1.add(value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Email is required";
              }

              return null;
            },
          ),
          const VerticalSpacer(25),
          TextFormFieldCustom(
            label: "Password",
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
            onChanged: (value) => buttonManager.setTextField2.add(value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Password is required";
              }

              return null;
            },
            obscureText: ref.watch(showPasswordProvider),
            suffix: IconButton(
              onPressed: () {
                ref.read(showPasswordProvider.notifier).state =
                    !ref.watch(showPasswordProvider);
              },
              icon: ref.watch(showPasswordProvider)
                  ? const Icon(Icons.visibility_off_rounded)
                  : const Icon(Icons.visibility),
            ),
          ),
          const VerticalSpacer(25),
          AsyncSnapshotStreamBuilder(
            stream: buttonManager.isShowButton,
            onActive: (context, data) {
              final isShow = data ?? false;
              return AppButton(
                title: 'Sign In',
                onPressed: isShow
                    ? () {
                        if (_key.currentState!.validate()) {
                          ref.read(signInUseCaseProvider.notifier).execute(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                        }
                      }
                    : null,
              );
            },
          ),
          const VerticalSpacer(15),
          TextButtonCustom(
            text: "Forget Password",
            onClick: () {
              context.push(Routes.forgetPassword);
            },
          ),
        ],
      ),
    );
  }
}
