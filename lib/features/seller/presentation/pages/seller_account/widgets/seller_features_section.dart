import 'package:fiverr/core/components/horizontal_spacer.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/core/providers/user/user_provider.dart';
import 'package:fiverr/features/seller/domain/entity/seller_entity.dart';
import 'package:fiverr/features/seller/presentation/pages/seller_account/widgets/border_container_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SellerFeaturesSection<T> extends ConsumerWidget {
  const SellerFeaturesSection({
    super.key,
    required this.list,
    required this.title,
    required this.data,
    required this.onClick,
  });
  final List<T> list;
  final String title;
  final SellerEntity data;
  final void Function() onClick;

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
              title,
              style: context.titleLarge!
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            if (user?.id == data.user.id)
              BorderContainerCustom(
                onClick: onClick,
                child: const Icon(
                  Icons.edit_outlined,
                  color: AppColor.primaryColor,
                  size: 22,
                ),
              ),
          ],
        ),
        const VerticalSpacer(15),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: list
              .expand((element) => [
                    if (element is SellerOccupationEntity)
                      Chip(
                        label: Text(
                          element.specialization,
                          style: context.titleSmall!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColor.whiteColor),
                        ),
                        backgroundColor: AppColor.primaryColor.withOpacity(0.6),
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    if (element is SellerLanguageEntity)
                      Chip(
                        label: Text(
                          element.language,
                          style: context.titleSmall!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColor.whiteColor),
                        ),
                        backgroundColor: AppColor.primaryColor.withOpacity(0.6),
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    if (element is SellerSkillEntity)
                      Chip(
                        label: Text(
                          element.skill,
                          style: context.titleSmall!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColor.whiteColor),
                        ),
                        backgroundColor: AppColor.primaryColor.withOpacity(0.6),
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    const HorizontalSpacer(5),
                  ])
              .toList(),
        )
      ],
    );
  }
}
