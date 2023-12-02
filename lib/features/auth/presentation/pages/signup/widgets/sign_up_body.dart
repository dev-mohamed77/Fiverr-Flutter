import 'package:fiverr/core/components/app_button.dart';
import 'package:fiverr/core/components/async_snapshot_builder.dart';
import 'package:fiverr/core/components/text_form_field_custom.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/manager/dialog/dialog_custom.dart';
import 'package:fiverr/core/manager/router/routes.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/auth/presentation/manager/providers.dart';
import 'package:fiverr/features/auth/presentation/manager/show_password_manager.dart';
import 'package:fiverr/features/auth/presentation/manager/signup_button_manager.dart';
import 'package:fiverr/features/auth/presentation/pages/signup/widgets/term_of_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignUpBody extends ConsumerStatefulWidget {
  const SignUpBody({super.key});

  @override
  ConsumerState<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends ConsumerState<SignUpBody> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _usernameController;
  late SignUpButtonManager signUpButtonManager;

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _usernameController = TextEditingController();
    signUpButtonManager = SignUpButtonManager();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    signUpButtonManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signUp = ref.watch(signUpUseCaseProvider);
    ref.listen(signUpUseCaseProvider, (previous, next) {
      next.maybeWhen(
        orElse: () {},
        data: (data) {
          DialogCustom.showSnackBar(
            context,
            message: "Sign up Successfully",
            color: AppColor.primaryColor,
          ).then((_) {
            context.push(Routes.signIn);
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
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: _key,
          child: Column(
            children: [
              const VerticalSpacer(50),
            signUp.isLoading
                ? const LinearProgressIndicator(
                    color: AppColor.primaryColor,
                  )
                : const SizedBox.shrink(),
            const VerticalSpacer(50),
              TextFormFieldCustom(
                label: "Email",
                controller: _emailController,
                onChanged: (value) => signUpButtonManager.setEmail.add(value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is required";
                  }

                  return null;
                },
              ),
              const VerticalSpacer(25),
              TextFormFieldCustom(
                label: "username",
                controller: _usernameController,
                onChanged: (value) =>
                    signUpButtonManager.setUsername.add(value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Username is required";
                  }

                  return null;
                },
              ),
              const VerticalSpacer(25),
              TextFormFieldCustom(
                label: "password",
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                onChanged: (value) =>
                    signUpButtonManager.setPassword.add(value),
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
              const VerticalSpacer(35),
              AsyncSnapshotStreamBuilder(
                  stream: signUpButtonManager.isShowButton,
                  onActive: (context, data) {
                    final isShow = data ?? false;
                    return AppButton(
                      title: 'Sign Up',
                      onPressed: isShow
                          ? () {
                              if (_key.currentState!.validate()) {
                                ref
                                    .read(signUpUseCaseProvider.notifier)
                                    .execute(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                      name: _usernameController.text,
                                    );
                              }
                            }
                          : null,
                    );
                  }),
              const VerticalSpacer(15),
              const TermOfService(),
            ],
          ),
        ),
      ),
    );
  }
}
