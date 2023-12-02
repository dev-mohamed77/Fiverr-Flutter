import 'package:fiverr/core/components/app_button.dart';
import 'package:fiverr/core/components/async_value.dart';
import 'package:fiverr/core/components/centered_message.dart';
import 'package:fiverr/core/components/gig_horizontal_item.dart';
import 'package:fiverr/core/extension/responsive_size_extensions.dart';
import 'package:fiverr/core/manager/router/routes.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/gig_details/presentation/manager/provider.dart';
import 'package:fiverr/features/gigs/presentation/manager/providers.dart';
import 'package:fiverr/features/reviews/presentation/manager/providers.dart';
import 'package:fiverr/features/seller/domain/entity/seller_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SellerGigsSection extends ConsumerStatefulWidget {
  const SellerGigsSection({
    super.key,
    this.seller,
  });
  final SellerEntity? seller;

  @override
  ConsumerState<SellerGigsSection> createState() => _SellerGigsSectionState();
}

class _SellerGigsSectionState extends ConsumerState<SellerGigsSection> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          ref
              .read(getGigsBySellerIdUseCaseProvider.notifier)
              .loadedMoreData(widget.seller?.id ?? "");
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gigs = ref.watch(getGigsBySellerIdUseCaseProvider);
    final gigsNotifier = ref.watch(getGigsBySellerIdUseCaseProvider.notifier);

    return AsyncValueWidget(
      value: gigs,
      data: (data) {
        return Column(
          children: [
            Expanded(
              child: data!.isNotEmpty
                  ? ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.only(bottom: 30),
                      itemBuilder: (context, index) {
                        if (data.length == index) {
                          if (!gigsNotifier.noItemMore) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: AppColor.primaryColor,
                              ),
                            );
                          } else if (gigsNotifier.noItemMore) {
                            return const CenteredMessage('No more items');
                          } else {
                            return const SizedBox.shrink();
                          }
                        }

                        return GigHorizontalItem(
                          seller: widget.seller,
                          gig: data[index],
                          onClick: () {
                            Future.wait([
                              ref
                                  .read(getReviewsUseCaseProvider.notifier)
                                  .execute(
                                    gigId: data[index].id,
                                    limit: "10",
                                    sort: "DESC",
                                  ),
                              ref
                                  .read(gigDetailsUseCaseProvider.notifier)
                                  .execute(id: data[index].id),
                            ]);

                            context.push(Routes.gigDetails);
                          },
                        );
                      },
                      itemCount: data.length,
                    )
                  : const CenteredMessage("No Gigs Yet."),
            ),
            Container(
              width: context.width,
              height: 70,
              padding: const EdgeInsets.only(
                  bottom: 13, top: 7, left: 15, right: 15),
              child: AppButton(
                title: "Create Gig",
                onPressed: () {
                  context.push(Routes.createGig);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
