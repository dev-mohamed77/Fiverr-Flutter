import 'package:flutter/material.dart';

class VerticalSpacer extends StatelessWidget {
  const VerticalSpacer(this._height, {super.key});

  final double _height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
    );
  }
}
