import 'package:fiverr/core/extension/responsive_size_extensions.dart';
import 'package:fiverr/features/welcome/presentation/pages/widgets/content_section.dart';
import 'package:fiverr/features/welcome/presentation/pages/widgets/video_section.dart';
import 'package:flutter/material.dart';

class WelcomeBody extends StatelessWidget {
  const WelcomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height,
      width: context.width,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          const VideoSection(),
          Container(
            color: Colors.black45,
          ),
          const ContentSection(),
        ],
      ),
    );
  }
}
