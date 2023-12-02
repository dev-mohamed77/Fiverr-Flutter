import 'package:fiverr/core/components/horizontal_spacer.dart';
import 'package:fiverr/core/extension/responsive_size_extensions.dart';
import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/core/manager/dialog/dialog_custom.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/gig_details/presentation/pages/widgets/bottom_sheet_seller_widget.dart';
import 'package:fiverr/features/gigs/domain/entity/gig_entity.dart';
import 'package:fiverr/features/seller/presentation/managers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SellerSection extends ConsumerWidget {
  const SellerSection({super.key, required this.seller});
  final GigSellerEntity seller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.read(getSellerByIdUseCaseProvider.notifier).execute(seller.id);
        DialogCustom.showModelBottomSheetCustom(
          context,
          child: const BottomSheetSellerWidget(),
        );
      },
      child: Container(
        width: context.width,
        height: context.height * 0.085,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: AppColor.greyColor.withOpacity(0.19),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundImage: NetworkImage(seller.picture),
            ),
            const HorizontalSpacer(10),
            Expanded(
              child: Text(
                seller.displayName,
                style:
                    context.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down_outlined,
              color: AppColor.greyColor,
            ),
          ],
        ),
      ),
    );
  }
}
