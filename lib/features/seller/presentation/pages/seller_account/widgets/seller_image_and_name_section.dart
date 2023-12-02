import 'dart:io';

import 'package:fiverr/core/components/app_button.dart';
import 'package:fiverr/core/components/horizontal_spacer.dart';
import 'package:fiverr/core/components/loading_linear_progress_custom.dart';
import 'package:fiverr/core/components/text_form_field_custom.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/extension/responsive_size_extensions.dart';
import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/core/manager/dialog/dialog_custom.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/core/providers/user/user_provider.dart';
import 'package:fiverr/features/seller/domain/entity/seller_entity.dart';
import 'package:fiverr/features/seller/presentation/managers/image_picker_manager.dart';
import 'package:fiverr/features/seller/presentation/managers/providers.dart';
import 'package:fiverr/features/seller/presentation/pages/seller_account/widgets/border_container_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class SellerImageAndNameSection extends ConsumerWidget {
  const SellerImageAndNameSection({super.key, required this.data});

  final SellerEntity data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            const SizedBox(
              height: 110,
              width: 50,
            ),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(data.picture),
            ),
            if (user?.id == data.user.id)
              Positioned(
                bottom: 5,
                left: 6,
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: const BoxDecoration(
                    color: AppColor.whiteColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            if (user?.id == data.user.id)
              Positioned(
                bottom: -2,
                child: IconButton(
                  onPressed: () {
                    DialogCustom.showModelBottomSheetCustom(
                      context,
                      child: UpdateSellerImageItem(
                        sellerId: data.id,
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.edit_outlined,
                    color: AppColor.primaryColor,
                  ),
                ),
              )
          ],
        ),
        const HorizontalSpacer(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const VerticalSpacer(3),
              Text(
                data.fullName,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: context.titleMedium!
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 19),
              ),
              const VerticalSpacer(7),
              Text(
                "@${data.displayName}",
                style: context.titleSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColor.greyColor,
                ),
              ),
              const VerticalSpacer(7),
              Text(
                user?.country ?? "",
                style: context.titleSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColor.greyColor,
                ),
              ),
            ],
          ),
        ),
        if (user?.id == data.user.id)
          BorderContainerCustom(
            onClick: () {
              DialogCustom.showModelBottomSheetCustom(
                context,
                child: UpdateSellerFullNameAndDisplayNameItem(
                  sellerId: data.id,
                ),
              );
            },
            child: const Icon(
              Icons.edit_outlined,
              color: AppColor.primaryColor,
              size: 22,
            ),
          ),
      ],
    );
  }
}

class UpdateSellerFullNameAndDisplayNameItem extends ConsumerStatefulWidget {
  const UpdateSellerFullNameAndDisplayNameItem({
    super.key,
    required this.sellerId,
  });
  final String sellerId;

  @override
  ConsumerState<UpdateSellerFullNameAndDisplayNameItem> createState() =>
      _UpdateSellerFullNameAndDisplayNameItemState();
}

class _UpdateSellerFullNameAndDisplayNameItemState
    extends ConsumerState<UpdateSellerFullNameAndDisplayNameItem> {
  late TextEditingController _fullNameController;
  late TextEditingController _displayNameController;

  @override
  void initState() {
    _fullNameController = TextEditingController();
    _displayNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _displayNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final updateSeller = ref.watch(updateSellerUseCaseProvider);

    ref.listen(
      updateSellerUseCaseProvider,
      (previous, next) {
        next.maybeWhen(
          orElse: () {},
          data: (data) {
            DialogCustom.showToast(
              message: "Description has been updated successfully",
              color: AppColor.primaryColor,
            );
            ref.read(getSellerByLoggedUserUseCaseProvider.notifier).execute();
            context.pop();
          },
          error: (error, stackTrace) {
            DialogCustom.showToast(
              message: error.toString(),
              color: AppColor.redColor,
            );
          },
        );
      },
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => context.pop(),
            child: const Icon(
              Icons.arrow_back_ios_outlined,
            ),
          ),
          const VerticalSpacer(7),
          LoadingLinearProgress(value: updateSeller),
          const VerticalSpacer(7),
          TextFormFieldCustom(
            controller: _fullNameController,
            label: "Full name",
            height: context.height * 0.1,
            maxLines: 1,
            maxLength: 50,
          ),
          const VerticalSpacer(20),
          TextFormFieldCustom(
            controller: _displayNameController,
            label: "Display name",
            height: context.height * 0.1,
            maxLines: 1,
            maxLength: 50,
          ),
          const VerticalSpacer(20),
          SizedBox(
            width: context.width,
            child: AppButton(
              title: "Update Seller",
              onPressed: () {
                ref.read(updateSellerUseCaseProvider.notifier).execute(
                      widget.sellerId,
                      fullName: _fullNameController.text,
                      displayName: _displayNameController.text,
                    );
              },
            ),
          ),
          const VerticalSpacer(30),
        ],
      ),
    );
  }
}

class UpdateSellerImageItem extends ConsumerWidget {
  const UpdateSellerImageItem({
    super.key,
    required this.sellerId,
  });
  final String sellerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final updateSeller = ref.watch(updateSellerUseCaseProvider);

    ref.listen(
      updateSellerUseCaseProvider,
      (previous, next) {
        next.maybeWhen(
          orElse: () {},
          data: (data) {
            DialogCustom.showToast(
              message: "Image has been updated successfully",
              color: AppColor.primaryColor,
            );
            ref.read(getSellerByLoggedUserUseCaseProvider.notifier).execute();
            ref.read(imagePickerProvider.notifier).removeImagePick();
            context.pop();
          },
          error: (error, stackTrace) {
            DialogCustom.showToast(
              message: error.toString(),
              color: AppColor.redColor,
            );
            ref.read(imagePickerProvider.notifier).removeImagePick();
          },
        );
      },
    );

    final image = ref.watch(imagePickerProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          LoadingLinearProgress(value: updateSeller),
          const VerticalSpacer(7),
          InkWell(
            onTap: () {
              ref
                  .read(imagePickerProvider.notifier)
                  .addImage(ImageSource.gallery);
            },
            borderRadius: BorderRadius.circular(50),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColor.greyColor.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
              child: image == null
                  ? Icon(
                      Icons.add,
                      size: 50,
                      color: AppColor.greyColor.withOpacity(0.6),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.file(
                        File(image.path),
                        fit: BoxFit.fill,
                      ),
                    ),
            ),
          ),
          const VerticalSpacer(20),
          SizedBox(
            width: context.width,
            child: AppButton(
              title: "Update description",
              onPressed: () {
                if (image != null) {
                  ref
                      .read(updateSellerUseCaseProvider.notifier)
                      .execute(sellerId, image: image.path);
                } else {
                  DialogCustom.showToast(
                    message: "Image is required",
                    color: AppColor.redColor,
                    gravity: ToastGravity.TOP,
                  );
                }
              },
            ),
          ),
          const VerticalSpacer(30),
        ],
      ),
    );
  }
}
