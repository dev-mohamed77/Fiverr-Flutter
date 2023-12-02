import 'package:cached_network_image/cached_network_image.dart';
import 'package:fiverr/core/extension/responsive_size_extensions.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/gigs/domain/entity/gig_entity.dart';
import 'package:flutter/material.dart';

class ImagesSection extends StatelessWidget {
  const ImagesSection({super.key, required this.gigImage});

  final List<GigImageEntity> gigImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      height: context.height * .35,
      child: Stack(
        children: [
          PageView.builder(
            itemCount: gigImage.length,
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                placeholder: (context, url) =>const Center(
                  child:  CircularProgressIndicator(
                    color: AppColor.primaryColor,
                  ),
                ),
                imageUrl: gigImage[index].src,
                fit: BoxFit.fill,
              );
            },
          ),
        ],
      ),
    );
  }
}
