import 'package:fiverr/core/config/app_assets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final iconsProvider = Provider<List<String>>(
  (ref) => [
    AppAssets.design,
    AppAssets.programming,
    AppAssets.marketing,
    AppAssets.video,
    AppAssets.writing,
    AppAssets.music,
    AppAssets.business,
    AppAssets.data,
    AppAssets.camera,
    AppAssets.ai,
  ],
);
