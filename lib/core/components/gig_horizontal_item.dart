import 'package:cached_network_image/cached_network_image.dart';
import 'package:fiverr/core/components/app_button.dart';
import 'package:fiverr/core/components/horizontal_spacer.dart';
import 'package:fiverr/core/components/loading_linear_progress_custom.dart';
import 'package:fiverr/core/components/review_and_favorite.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/extension/responsive_size_extensions.dart';
import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/core/manager/dialog/dialog_custom.dart';
import 'package:fiverr/core/manager/router/routes.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/gigs/domain/entity/gig_entity.dart';
import 'package:fiverr/features/gigs/presentation/manager/providers.dart';
import 'package:fiverr/features/seller/domain/entity/seller_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class GigHorizontalItem extends StatelessWidget {
  const GigHorizontalItem({
    super.key,
    required this.gig,
    this.seller,
    required this.onClick,
  });

  final GigEntity gig;
  final SellerEntity? seller;
  final void Function() onClick;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        color: AppColor.whiteColor,
        surfaceTintColor: AppColor.whiteColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: onClick,
          child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(13),
                      topLeft: Radius.circular(13),
                    ),
                    child: CachedNetworkImage(
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(
                          color: AppColor.primaryColor,
                        ),
                      ),
                      imageUrl: gig.coverImage,
                      height: 120,
                      width: context.width / 2.8,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReviewAndFavorite(
                          padding: 10,
                          gig: gig,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            gig.title,
                            style: context.bodyMedium,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: [
                              const Spacer(),
                              Text(
                                "From",
                                style: context.bodySmall,
                              ),
                              const HorizontalSpacer(5),
                              Text(
                                "\$${gig.price}",
                                style: context.titleMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              if (seller != null && seller?.id == gig.seller.id)
                Column(
                  children: [
                    const VerticalSpacer(15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: context.width / 2.8,
                          child: AppButton(
                            height: 40,
                            color: AppColor.redColor,
                            title: "Delete",
                            onPressed: () {
                              DialogCustom.showModelBottomSheetCustom(
                                context,
                                child: DeleteGigBottomSheet(
                                  gigId: gig.id,
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: context.width / 2.8,
                          child: AppButton(
                            height: 40,
                            title: "Update",
                            onPressed: () {
                              context.push(Routes.updateGig, extra: gig);
                            },
                          ),
                        ),
                      ],
                    ),
                    const VerticalSpacer(10),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class DeleteGigBottomSheet extends ConsumerWidget {
  const DeleteGigBottomSheet({super.key, required this.gigId});
  final String gigId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deleteGig = ref.watch(deleteGigUseCaseProvider);

    ref.listen(deleteGigUseCaseProvider, (previous, next) {
      next.maybeWhen(
        orElse: () {},
        data: (data) {
          DialogCustom.showToast(
            message: data!,
            color: AppColor.primaryColor,
            gravity: ToastGravity.TOP,
          );
          context.pop();
          ref.read(getGigsBySellerIdUseCaseProvider.notifier).deleteGig(gigId);
        },
        error: (error, stackTrace) {
          DialogCustom.showToast(
            message: error.toString(),
            color: AppColor.redColor,
            gravity: ToastGravity.TOP,
          );
        },
      );
    });

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const VerticalSpacer(25),
        LoadingLinearProgress(value: deleteGig),
        const VerticalSpacer(25),
        Text(
          "Do you want to delete the gig?",
          style: context.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        const VerticalSpacer(15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: context.width / 2.8,
              child: AppButton(
                height: 40,
                title: "cancel",
                onPressed: () {
                  context.pop();
                },
              ),
            ),
            SizedBox(
              width: context.width / 2.8,
              child: AppButton(
                height: 40,
                color: AppColor.redColor,
                title: "Delete",
                onPressed: () {
                  ref.read(deleteGigUseCaseProvider.notifier).execute(gigId);
                },
              ),
            ),
          ],
        ),
        const VerticalSpacer(50),
      ],
    );
  }
}
