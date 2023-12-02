import 'package:flutter/material.dart';

class HorizontalSpacer extends StatelessWidget {
  const HorizontalSpacer(this._width, {super.key});

  final double _width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _width,
    );
  }
}
