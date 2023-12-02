import 'package:fiverr/core/components/async_value.dart';
import 'package:fiverr/core/components/centered_message.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/manager/router/routes.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/chat/presentation/manager/providers.dart';
import 'package:fiverr/features/chat/presentation/manager/select_conversation_provider.dart';
import 'package:fiverr/features/inbox/presentation/manager/providers.dart';
import 'package:fiverr/features/inbox/presentation/pages/widgets/conversation_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class InboxScreen extends ConsumerStatefulWidget {
  const InboxScreen({super.key});

  @override
  ConsumerState<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends ConsumerState<InboxScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          ref.read(getConversationsByUserIdUseCase.notifier).loadedMoreData();
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
    final conversation = ref.watch(getConversationsByUserIdUseCase);
    final conversationNotifier =
        ref.watch(getConversationsByUserIdUseCase.notifier);

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
                        "sender": "user",
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
