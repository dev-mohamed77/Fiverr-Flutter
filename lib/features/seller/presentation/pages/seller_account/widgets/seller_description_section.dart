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
import 'package:fiverr/features/seller/presentation/managers/providers.dart';
import 'package:fiverr/features/seller/presentation/pages/seller_account/widgets/border_container_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SellerDescriptionSection extends ConsumerWidget {
  const SellerDescriptionSection({
    super.key,
    required this.data,
  });

  final SellerEntity data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            data.description,
            style: context.titleSmall!
                .copyWith(fontWeight: FontWeight.bold, height: 1.7),
          ),
        ),
        const HorizontalSpacer(5),
        if (user?.id == data.user.id)
          BorderContainerCustom(
            onClick: () {
              DialogCustom.showModelBottomSheetCustom(context,
                  child: UpdateDescriptionItem(
                    sellerId: data.id,
                  ));
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

class UpdateDescriptionItem extends ConsumerStatefulWidget {
  const UpdateDescriptionItem({
    super.key,
    required this.sellerId,
  });
  final String sellerId;

  @override
  ConsumerState<UpdateDescriptionItem> createState() =>
      _UpdateDescriptionItemState();
}

class _UpdateDescriptionItemState extends ConsumerState<UpdateDescriptionItem> {
  late TextEditingController _descriptionController;

  @override
  void initState() {
    _descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
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
          LoadingLinearProgress(value: updateSeller),
          const VerticalSpacer(7),
          const Text("Description"),
          const VerticalSpacer(5),
          TextFormFieldCustom(
            controller: _descriptionController,
            label: "",
            height: context.height * 0.25,
            maxLines: 6,
            maxLength: 1000,
          ),
          const VerticalSpacer(20),
          SizedBox(
            width: context.width,
            child: AppButton(
              title: "Update description",
              onPressed: () {
                ref.read(updateSellerUseCaseProvider.notifier).execute(
                      widget.sellerId,
                      description: _descriptionController.text,
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
