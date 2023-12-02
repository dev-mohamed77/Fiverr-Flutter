import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

@immutable
class SignUpButtonManager {
  final Sink<String?> setEmail;
  final Sink<String?> setUsername;
  final Sink<String?> setPassword;
  final Stream<bool> isShowButton;

  const SignUpButtonManager._({
    required this.setEmail,
    required this.setUsername,
    required this.setPassword,
    required this.isShowButton,
  });

  dispose() {
    setEmail.close();
    setUsername.close();
    setPassword.close();
  }

  factory SignUpButtonManager() {
    final emailSubject = BehaviorSubject<String?>();
    final usernameSubject = BehaviorSubject<String?>();
    final passwordSubject = BehaviorSubject<String?>();

    final Stream<bool> isShowButton = Rx.combineLatest3(
        emailSubject.startWith(null),
        usernameSubject.startWith(null),
        passwordSubject.startWith(null), (email, username, password) {
      if (email != null &&
          email.isNotEmpty &&
          username != null &&
          username.isNotEmpty &&
          password != null &&
          password.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    });

    return SignUpButtonManager._(
      setEmail: emailSubject.sink,
      setUsername: usernameSubject.sink,
      setPassword: passwordSubject.sink,
      isShowButton: isShowButton,
    );
  }
}
