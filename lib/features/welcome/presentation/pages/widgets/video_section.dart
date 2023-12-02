import 'package:fiverr/core/config/app_assets.dart';
import 'package:fiverr/core/extension/responsive_size_extensions.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoSection extends StatefulWidget {
  const VideoSection({super.key});

  @override
  State<VideoSection> createState() => _VideoSectionState();
}

class _VideoSectionState extends State<VideoSection> {
  late VideoPlayerController controller;

  @override
  void initState() {
    controller = VideoPlayerController.asset(AppAssets.videoFreeLancer);
    controller.addListener(() {
      setState(() {});
    });
    controller.setLooping(true);
    controller.initialize().then((_) => setState(() {}));
    controller.play();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      height: context.height,
      child: VideoPlayer(controller),
    );
  }
}
