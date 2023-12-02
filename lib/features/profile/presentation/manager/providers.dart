import 'dart:async';

import 'package:fiverr/features/auth/domain/entity/signin_entity.dart';
import 'package:fiverr/features/profile/domain/entity/user_entity.dart';
import 'package:fiverr/features/profile/domain/repository/provider.dart';
import 'package:fiverr/features/profile/domain/usecase/change_password_usecase.dart';
import 'package:fiverr/features/profile/domain/usecase/update_user_usecase.dart';
import 'package:fiverr/features/profile/domain/usecase/user_get_me_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userGetMeUseCase = StateNotifierProvider.autoDispose<UserGetMeUseCase,
    AsyncValue<UserEntity?>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });
  final repo = ref.watch(userRepositoryProvider);
  return UserGetMeUseCase(repo, ref);
});

final updateUserUseCase = StateNotifierProvider.autoDispose<UpdateUserUseCase,
    AsyncValue<UserEntity?>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });
  final repo = ref.watch(userRepositoryProvider);
  return UpdateUserUseCase(repo, ref);
});

final changePasswordUseCase = StateNotifierProvider.autoDispose<
    ChangePasswordUseCase, AsyncValue<SignInEntity?>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });

  final repo = ref.watch(userRepositoryProvider);
  return ChangePasswordUseCase(repo, ref);
});
