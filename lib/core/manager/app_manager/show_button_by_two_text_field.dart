import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

@immutable
class ShowButtonByTwoTextField {
  final Sink<String?> setTextField1;
  final Sink<String?> setTextField2;
  final Stream<bool> isShowButton;

  const ShowButtonByTwoTextField._({
    required this.setTextField1,
    required this.setTextField2,
    required this.isShowButton,
  });

  dispose() {
    setTextField1.close();
    setTextField2.close();
  }

  factory ShowButtonByTwoTextField() {
    final setTextField1Subject = BehaviorSubject<String?>();
    final setTextField2Subject = BehaviorSubject<String?>();

    final Stream<bool> isShowButton = Rx.combineLatest2(
        setTextField1Subject.startWith(null),
        setTextField2Subject.startWith(null), (email, password) {
      if (email != null &&
          email.isNotEmpty &&
          password != null &&
          password.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    });

    return ShowButtonByTwoTextField._(
      setTextField1: setTextField1Subject.sink,
      setTextField2: setTextField2Subject.sink,
      isShowButton: isShowButton,
    );
  }
}
