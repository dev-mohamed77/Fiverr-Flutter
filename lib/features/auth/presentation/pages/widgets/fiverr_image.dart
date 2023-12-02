import 'package:fiverr/core/config/app_assets.dart';
import 'package:flutter/material.dart';

class FiverrImage extends StatelessWidget {
  const FiverrImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.fiverrImage,
      height: 50,
      width: 50,
      fit: BoxFit.cover,
    );
  }
}
