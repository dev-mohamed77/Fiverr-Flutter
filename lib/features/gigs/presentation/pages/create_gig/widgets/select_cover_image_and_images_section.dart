import 'dart:io';

import 'package:fiverr/core/components/horizontal_spacer.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/extension/responsive_size_extensions.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/gigs/presentation/manager/select_cover_image_picker_manager.dart';
import 'package:fiverr/features/gigs/presentation/manager/select_images_picker_manager.dart';
import 'package:fiverr/features/gigs/presentation/pages/create_gig/widgets/image_container_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class SelectCoverImageAndImagesSection extends ConsumerWidget {
  const SelectCoverImageAndImagesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectCoverImage = ref.watch(selectCoverImagePickerProvider);
    final selectImages = ref.watch(selectImagesPickerProvider);

    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Cover Image"),
            const VerticalSpacer(5),
            InkWell(
              onTap: () {
                ref
                    .read(selectCoverImagePickerProvider.notifier)
                    .addImage(ImageSource.gallery);
              },
              child: Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColor.greyColor.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: selectCoverImage == null
                    ? const Icon(
                        Icons.add,
                        color: Colors.black45,
                        size: 45,
                      )
                    : Image.file(
                        File(selectCoverImage.path),
                        fit: BoxFit.fill,
                      ),
              ),
            ),
          ],
        ),
        const VerticalSpacer(15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Images"),
            const VerticalSpacer(5),
            SizedBox(
              width: context.width,
              height: context.height * 0.1,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: selectImages != null
                    ? selectImages
                        .expand((image) => [
                              ImageContainerCustom(
                                onClick: () {
                                  ref
                                      .read(selectImagesPickerProvider.notifier)
                                      .addImages();
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.file(
                                    File(image.path),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              const HorizontalSpacer(5),
                            ])
                        .toList()
                    : [
                        ImageContainerCustom(
                          onClick: () {
                            ref
                                .read(selectImagesPickerProvider.notifier)
                                .addImages();
                          },
                          child: const Icon(
                            Icons.add,
                            color: Colors.black45,
                            size: 45,
                          ),
                        ),
                        const HorizontalSpacer(5),
                        ImageContainerCustom(
                          onClick: () {},
                          child: const Icon(
                            Icons.add,
                            color: Colors.black45,
                            size: 45,
                          ),
                        ),
                        const HorizontalSpacer(5),
                        ImageContainerCustom(
                          onClick: () {},
                          child: const Icon(
                            Icons.add,
                            color: Colors.black45,
                            size: 45,
                          ),
                        ),
                        const HorizontalSpacer(5),
                        ImageContainerCustom(
                          onClick: () {},
                          child: const Icon(
                            Icons.add,
                            color: Colors.black45,
                            size: 45,
                          ),
                        ),
                      ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
