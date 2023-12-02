// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fiverr/core/components/centered_message.dart';
import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/features/chat/presentation/manager/providers.dart';
import 'package:fiverr/features/chat/presentation/manager/select_conversation_provider.dart';
import 'package:fiverr/features/gigs/presentation/manager/providers.dart';
import 'package:fiverr/features/inbox/presentation/manager/providers.dart';
import 'package:fiverr/features/inbox/presentation/pages/widgets/conversation_item.dart';
import 'package:fiverr/features/order/presentation/managers/providers.dart';
import 'package:fiverr/features/seller/presentation/pages/seller_account/widgets/seller_about_section.dart';
import 'package:fiverr/features/seller/presentation/pages/seller_account/widgets/seller_gig_section.dart';
import 'package:fiverr/features/seller/presentation/pages/seller_account/widgets/seller_order_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fiverr/core/components/async_value.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/manager/dialog/dialog_custom.dart';
import 'package:fiverr/core/manager/router/routes.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/language/presentation/manager/providers.dart';
import 'package:fiverr/features/occupation/presentation/manager/providers.dart';
import 'package:fiverr/features/seller/domain/entity/seller_entity.dart';
import 'package:fiverr/features/seller/presentation/managers/providers.dart';
import 'package:fiverr/features/skill/presentation/manager/providers.dart';

class SellerAccountBody extends ConsumerStatefulWidget {
  const SellerAccountBody({
    super.key,
    required this.isSellerLoggedUser,
  });

  final bool isSellerLoggedUser;

  @override
  ConsumerState<SellerAccountBody> createState() => _SellerAccountBodyState();
}

class _SellerAccountBodyState extends ConsumerState<SellerAccountBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  SellerEntity? _currentSeller;

  @override
  Widget build(BuildContext context) {
    late AsyncValue<SellerEntity?> seller;

    if (widget.isSellerLoggedUser) {
      seller = ref.watch(getSellerByLoggedUserUseCaseProvider);
      _currentSeller = seller.value;

      ref.listen(
        getSellerByLoggedUserUseCaseProvider,
        (previous, next) {
          next.maybeWhen(
            orElse: () {},
            data: (data) {
              if (data!.language.isEmpty) {
                ref.read(getLanguageBySellerIdUseCaseProvider.notifier).execute(
                      sellerId: data.id,
                    );
                context.goNamed(
                  Routes.sellerLanguage,
                  extra: {
                    "sellerId": data.id,
                    "isSellerPage": false,
                  },
                );
              } else if (data.occupation.isEmpty) {
                ref
                    .read(getOccupationBySellerIdUseCaseProvider.notifier)
                    .execute(sellerId: data.id);
                context.goNamed(
                  Routes.sellerOccupation,
                  extra: {
                    "sellerId": data.id,
                    "isSellerPage": false,
                  },
                );
              } else if (data.skills.isEmpty) {
                ref
                    .read(getSkillsBySellerIdUseCaseProvider.notifier)
                    .execute(sellerId: data.id);
                context.goNamed(
                  Routes.sellerSkill,
                  extra: {
                    "sellerId": data.id,
                    "isSellerPage": false,
                  },
                );
              }
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
    } else {
      seller = ref.watch(getSellerByIdUseCaseProvider);
    }

    return AsyncValueWidget(
      value: seller,
      data: (data) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBar(
              padding: const EdgeInsets.symmetric(vertical: 5),
              labelPadding: const EdgeInsets.symmetric(vertical: 10),
              indicatorColor: AppColor.primaryColor,
              controller: _tabController,
              onTap: (index) {
                if (index == 1) {
                  ref.read(getGigsBySellerIdUseCaseProvider.notifier).execute(
                        data?.id ?? "",
                      );
                } else if (index == 2) {
                  ref.read(getOrderBySellerIdUseCaseProvider.notifier).execute(
                      data?.id ?? "",
                      status: "on progress",
                      limit: "25");
                } else if (index == 3) {
                  ref.read(getConversationsBySellerIdUseCase.notifier).execute(
                        sellerID: data?.id ?? "",
                      );
                }
              },
              tabs: [
                Text(
                  'About',
                  style: context.titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Gigs',
                  style: context.titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Orders",
                  style: context.titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Inbox",
                  style: context.titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const VerticalSpacer(12),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  SellerAboutSection(data: data!),
                  SellerGigsSection(seller: _currentSeller),
                  SellerOrderSection(seller: data),
                  SellerInboxSection(
                    sellerId: data.id,
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class SellerInboxSection extends ConsumerStatefulWidget {
  const SellerInboxSection({super.key, required this.sellerId});

  final String sellerId;

  @override
  ConsumerState<SellerInboxSection> createState() => _SellerInboxSectionState();
}

class _SellerInboxSectionState extends ConsumerState<SellerInboxSection> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          ref
              .read(getConversationsBySellerIdUseCase.notifier)
              .loadedMoreData(widget.sellerId);
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
    final conversation = ref.watch(getConversationsBySellerIdUseCase);
    final conversationNotifier =
        ref.watch(getConversationsBySellerIdUseCase.notifier);

    return AsyncValueWidget(
      value: conversation,
      data: (data) {
        if (data.isEmpty) {
          return const CenteredMessage("No Conversations yet .");
        }

        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                controller: _scrollController,
                itemBuilder: (context, index) {
                  if (data.length == index) {
                    if (!conversationNotifier.noItemMore) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColor.primaryColor,
                        ),
                      );
                    } else if (conversationNotifier.noItemMore) {
                      return const CenteredMessage('No more items');
                    } else {
                      return const SizedBox.shrink();
                    }
                  }

                  return InkWell(
                    onTap: () {
                      context.push(Routes.chat, extra: {
                        "sellerId": data[index].seller.id,
                        "sender": "seller",
                      });

                      ref
                          .read(selectConversationProvider.notifier)
                          .update((state) => data[index]);

                      ref
                          .read(getMessagesByConversationIDUseCaseProvider
                              .notifier)
                          .execute(conversationId: data[index].id);
                    },
                    child: ConversationItem(
                      conversation: data[index],
                      isUser: false,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const VerticalSpacer(3);
                },
                itemCount: data.length,
              ),
            )
          ],
        );
      },
    );
  }
}
