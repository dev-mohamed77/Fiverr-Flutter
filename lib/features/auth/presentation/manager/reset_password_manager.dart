import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

@immutable
class ResetPasswordButtonManager {
  final Sink<String?> setPassword;
  final Sink<String?> setConfirmPassword;
  final Stream<bool> isShowButton;

  const ResetPasswordButtonManager._({
    required this.setPassword,
    required this.setConfirmPassword,
    required this.isShowButton,
  });

  dispose() {
    setPassword.close();
    setConfirmPassword.close();
  }

  factory ResetPasswordButtonManager() {
    final passwordSubject = BehaviorSubject<String?>();
    final confirmPasswordSubject = BehaviorSubject<String?>();

    final Stream<bool> isShowButton = Rx.combineLatest2(
      passwordSubject.startWith(null),
      confirmPasswordSubject.startWith(null),
      (password, confirmPassword) {
        if (password != null &&
            password.isNotEmpty &&
            confirmPassword != null &&
            confirmPassword.isNotEmpty) {
          if (password != confirmPassword) {
            return false;
          } else {
            return true;
          }
        } else {
          return false;
        }
      },
    ).asBroadcastStream();

    return ResetPasswordButtonManager._(
      setPassword: passwordSubject.sink,
      setConfirmPassword: confirmPasswordSubject.sink,
      isShowButton: isShowButton,
    );
  }
}
