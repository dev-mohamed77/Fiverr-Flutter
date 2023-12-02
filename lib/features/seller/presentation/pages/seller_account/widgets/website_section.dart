import 'package:fiverr/core/components/app_button.dart';
import 'package:fiverr/core/components/loading_linear_progress_custom.dart';
import 'package:fiverr/core/components/text_form_field_custom.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/extension/responsive_size_extensions.dart';
import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/core/manager/dialog/dialog_custom.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/core/providers/user/user_provider.dart';
import 'package:fiverr/features/seller/domain/entity/seller_entity.dart';
import 'package:fiverr/features/seller/presentation/managers/providers.dart';
import 'package:fiverr/features/seller/presentation/pages/seller_account/widgets/border_container_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WebsiteSection extends ConsumerWidget {
  const WebsiteSection({
    Key? key,
    required this.data,
  }) : super(key: key);

  final SellerEntity data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Website",
              style: context.titleLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
            if (user?.id == data.user.id)
              BorderContainerCustom(
                onClick: () {
                  DialogCustom.showModelBottomSheetCustom(context,
                      child: UpdateSellerWebsiteItem(
                        sellerId: data.id,
                      ));
                },
                child: data.website.isNotEmpty || data.website != ""
                    ? const Icon(
                        Icons.edit_outlined,
                        color: AppColor.primaryColor,
                        size: 22,
                      )
                    : const Icon(
                        Icons.add,
                        color: AppColor.primaryColor,
                        size: 22,
                      ),
              ),
          ],
        ),
        const VerticalSpacer(15),
        Text(
          data.website,
          style: context.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

class UpdateSellerWebsiteItem extends ConsumerStatefulWidget {
  const UpdateSellerWebsiteItem({
    super.key,
    required this.sellerId,
  });
  final String sellerId;

  @override
  ConsumerState<UpdateSellerWebsiteItem> createState() =>
      _UpdateSellerWebsiteItemState();
}

class _UpdateSellerWebsiteItemState
    extends ConsumerState<UpdateSellerWebsiteItem> {
  late TextEditingController _websiteController;

  @override
  void initState() {
    _websiteController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _websiteController.dispose();
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
              message: "Website has been updated successfully",
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
          const VerticalSpacer(10),
          LoadingLinearProgress(value: updateSeller),
          const VerticalSpacer(7),
          TextFormFieldCustom(
            controller: _websiteController,
            label: "Website",
            height: context.height * 0.1,
            maxLines: 1,
            maxLength: 256,
          ),
          const VerticalSpacer(20),
          SizedBox(
            width: context.width,
            child: AppButton(
              title: "Update Website",
              onPressed: () {
                ref.read(updateSellerUseCaseProvider.notifier).execute(
                      widget.sellerId,
                      website: _websiteController.text,
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
