import 'package:flutter/material.dart';

extension PaddingList on List<Widget> {
  List<Widget> paddingDirectional({
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return map((e) => Padding(
            padding: EdgeInsets.only(
          top: top ?? 0,
          bottom: bottom ?? 0,
          left: left ?? 0,
          right: right ?? 0,
        ))).toList();
  }
}
