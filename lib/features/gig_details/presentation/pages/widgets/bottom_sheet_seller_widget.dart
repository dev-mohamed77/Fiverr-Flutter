import 'package:fiverr/core/components/app_button.dart';
import 'package:fiverr/core/components/horizontal_spacer.dart';
import 'package:fiverr/core/components/text_button_custom.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/extension/responsive_size_extensions.dart';
import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/core/manager/router/routes.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/core/providers/user/user_provider.dart';
import 'package:fiverr/features/seller/presentation/managers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BottomSheetSellerWidget extends ConsumerWidget {
  const BottomSheetSellerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seller = ref.watch(getSellerByIdUseCaseProvider);

    final user = ref.watch(userProvider);

    return seller.when(
      loading: () => SizedBox(
        width: double.infinity,
        height: context.height * 0.4,
        child: const Center(
          child: CircularProgressIndicator(
            color: AppColor.primaryColor,
          ),
        ),
      ),
      data: (data) {
        return SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(data?.picture ?? ""),
                    ),
                    const HorizontalSpacer(15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const VerticalSpacer(2),
                          Text(
                            data?.displayName ?? "",
                            style: context.titleSmall!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            user?.country ?? "",
                            style: context.bodySmall!
                                .copyWith(color: AppColor.greyColor),
                          ),
                        ],
                      ),
                    ),
                    TextButtonCustom(text: "Contact", onClick: () {}),
                  ],
                ),
                const VerticalSpacer(15),
                Text(
                  "User Information",
                  style: context.titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const VerticalSpacer(10),
                Text(
                  data?.description ?? "",
                  style: context.titleSmall!,
                ),
                const VerticalSpacer(15),
                _infoItem(
                  context,
                  icon: Icons.web_rounded,
                  title: 'From',
                  subTitle: data?.website ?? "",
                ),
                const VerticalSpacer(10),
                _infoItem(
                  context,
                  icon: Icons.g_translate_outlined,
                  title: 'Language',
                  subTitle: data?.language[1].language ?? "",
                ),
                const VerticalSpacer(10),
                _infoItem(
                  context,
                  icon: Icons.message_outlined,
                  title: 'Avg, response time',
                  subTitle: '1 Hour',
                ),
                const VerticalSpacer(20),
                AppButton(
                  title: "See Full Profile",
                  onPressed: () {
                    ref
                        .read(getSellerByIdUseCaseProvider.notifier)
                        .execute(data?.id ?? "");

                    context.push(Routes.sellerAccount);
                  },
                ),
                const VerticalSpacer(20),
              ],
            ),
          ),
        );
      },
      error: (Object error, StackTrace stackTrace) {
        return Center(
          child: Text(error.toString()),
        );
      },
    );
  }

  Widget _infoItem(
    BuildContext ctx, {
    required IconData icon,
    required String title,
    required String subTitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: AppColor.greyColor,
          size: 25,
        ),
        const HorizontalSpacer(20),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: ctx.bodySmall!.copyWith(color: AppColor.greyColor),
            ),
            Text(
              subTitle,
              style: ctx.titleMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ))
      ],
    );
  }
}
