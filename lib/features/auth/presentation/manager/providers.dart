import 'dart:async';

import 'package:fiverr/features/auth/data/repository/auth_repository.dart';
import 'package:fiverr/features/auth/data/repository/signin_repository.dart';
import 'package:fiverr/features/auth/data/repository/signup_repository.dart';
import 'package:fiverr/features/auth/domain/entity/signin_entity.dart';
import 'package:fiverr/features/profile/domain/entity/user_entity.dart';
import 'package:fiverr/features/auth/domain/usecase/auth_usecase.dart';
import 'package:fiverr/features/auth/domain/usecase/forget_password_usecase.dart';
import 'package:fiverr/features/auth/domain/usecase/reset_password_usecase.dart';
import 'package:fiverr/features/auth/domain/usecase/signin_usecase.dart';
import 'package:fiverr/features/auth/domain/usecase/signup_usecase.dart';
import 'package:fiverr/features/auth/domain/usecase/verify_reset_code_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authUseCaseProvider =
    StateNotifierProvider.autoDispose<AuthUseCase, AsyncValue<SignInEntity?>>(
        (ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });
  final authRepo = ref.watch(authRepositoryProvider);
  return AuthUseCase(authRepo);
});

final signInUseCaseProvider =
    StateNotifierProvider.autoDispose<SignInUseCase, AsyncValue<SignInEntity?>>(
        (ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });
  final signInRepo = ref.watch(signInRepositoryProvider);
  return SignInUseCase(signInRepo);
});

final signUpUseCaseProvider =
    StateNotifierProvider.autoDispose<SignUpUseCase, AsyncValue<UserEntity?>>(
        (ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });
  final signUpRepo = ref.watch(signUpRepositoryProvider);
  return SignUpUseCase(signUpRepo);
});

final forgetPasswordUseCaseProvider = StateNotifierProvider.autoDispose<
    ForgetPasswordUseCase, AsyncValue<String?>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });
  final signInRepo = ref.watch(signInRepositoryProvider);
  return ForgetPasswordUseCase(signInRepo);
});

final verifyResetCodeUseCaseProvider = StateNotifierProvider.autoDispose<
    VerifyResetCodeUseCase, AsyncValue<UserEntity?>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });
  final signInRepo = ref.watch(signInRepositoryProvider);
  return VerifyResetCodeUseCase(signInRepo);
});

final resetPasswordUseCaseProvider = StateNotifierProvider.autoDispose<
    ResetPasswordUseCase, AsyncValue<SignInEntity?>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });
  final signInRepo = ref.watch(signInRepositoryProvider);
  return ResetPasswordUseCase(signInRepo, ref);
});
