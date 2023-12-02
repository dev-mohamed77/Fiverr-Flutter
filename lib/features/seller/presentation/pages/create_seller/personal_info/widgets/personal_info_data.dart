import 'dart:io';

import 'package:fiverr/core/components/app_button.dart';
import 'package:fiverr/core/components/loading_linear_progress_custom.dart';
import 'package:fiverr/core/components/text_form_field_custom.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/config/app_assets.dart';
import 'package:fiverr/core/extension/responsive_size_extensions.dart';
import 'package:fiverr/core/manager/dialog/dialog_custom.dart';
import 'package:fiverr/core/manager/router/routes.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/core/providers/user/user_provider.dart';
import 'package:fiverr/features/language/presentation/manager/providers.dart';
import 'package:fiverr/features/seller/presentation/managers/field_required.dart';
import 'package:fiverr/features/seller/presentation/managers/image_picker_manager.dart';
import 'package:fiverr/features/seller/presentation/managers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class PersonalInfoDataSection extends ConsumerStatefulWidget {
  const PersonalInfoDataSection({super.key});

  @override
  ConsumerState<PersonalInfoDataSection> createState() =>
      _PersonalInfoDataSectionState();
}

class _PersonalInfoDataSectionState
    extends ConsumerState<PersonalInfoDataSection> {
  late TextEditingController webSiteController;

  @override
  void initState() {
    webSiteController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    webSiteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final image = ref.watch(imagePickerProvider);
    final showButtonSellerAccount = ref.watch(showButtonSellerAccountProvider);
    final createSeller = ref.watch(createSellerUseCaseProvider);

    ref.listen(
      createSellerUseCaseProvider,
      (previous, next) {
        next.maybeWhen(
          orElse: () {},
          data: (data) {
            DialogCustom.showSnackBar(
              context,
              message: "A seller account has been created successfully",
              color: AppColor.primaryColor,
            ).then((_) {
              context.go(
                Routes.sellerLanguage,
                extra: {
                  "sellerId": data!.id,
                  "isSellerPage": false,
                },
              );
              ref
                  .read(getLanguageBySellerIdUseCaseProvider.notifier)
                  .execute(sellerId: data.id);
              ref
                  .read(userProvider.notifier)
                  .update((state) => state?.copyWith(isSeller: true));
            });
          },
          error: (error, stackTrace) {
            DialogCustom.showSnackBar(
              context,
              message: error.toString(),
              color: AppColor.redColor,
            );
          },
        );
      },
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: context.width / 3.1,
          height: context.width / 3.1,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: image != null
                    ? FileImage(
                        File(image.path),
                      )
                    : const AssetImage(
                        AppAssets.noProfile,
                      ) as ImageProvider,
              ),
              Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                  onPressed: () {
                    ref
                        .read(imagePickerProvider.notifier)
                        .addImage(ImageSource.gallery);
                  },
                  icon: const Icon(
                    Icons.photo_camera,
                    color: AppColor.greyColor,
                    size: 32,
                  ),
                ),
              ),
            ],
          ),
        ),
        const VerticalSpacer(10),
        LoadingLinearProgress(value: createSeller),
        const VerticalSpacer(10),
        TextFormFieldCustom(
          label: "Full Name",
          maxLength: 50,
          height: 70,
          onChanged: (value) => ref
              .read(fullNameSellerProvider.notifier)
              .update((state) => value),
        ),
        const VerticalSpacer(20),
        TextFormFieldCustom(
          height: 70,
          label: "Display Name",
          maxLength: 50,
          onChanged: (value) => ref
              .read(displayNameSellerProvider.notifier)
              .update((state) => value),
        ),
        const VerticalSpacer(15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Description"),
            const VerticalSpacer(5),
            TextFormFieldCustom(
              height: context.height * 0.2,
              label: "",
              maxLines: 10,
              minLines: 6,
              maxLength: 400,
              onChanged: (value) => ref
                  .read(descriptionSellerProvider.notifier)
                  .update((state) => value),
            ),
          ],
        ),
        const VerticalSpacer(15),
        TextFormFieldCustom(
          height: 70,
          label: "Website",
          maxLength: 50,
          controller: webSiteController,
        ),
        const VerticalSpacer(20),
        AppButton(
          title: "Continue",
          onPressed: showButtonSellerAccount.asData?.value ?? false == true
              ? () {
                  ref.read(createSellerUseCaseProvider.notifier).execute(
                        fullName: ref.watch(fullNameSellerProvider) ?? "",
                        displayName: ref.watch(displayNameSellerProvider) ?? "",
                        description: ref.watch(descriptionSellerProvider) ?? "",
                        website: webSiteController.text,
                        image: image!.path,
                      );
                }
              : null,
        ),
        const VerticalSpacer(50),
      ],
    );
  }
}
