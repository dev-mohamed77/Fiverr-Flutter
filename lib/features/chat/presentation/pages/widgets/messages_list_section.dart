import 'package:fiverr/core/components/async_value.dart';
import 'package:fiverr/core/components/centered_message.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/chat/presentation/manager/providers.dart';
import 'package:fiverr/features/chat/presentation/pages/widgets/message_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessagesListSection extends ConsumerStatefulWidget {
  const MessagesListSection({super.key});

  @override
  ConsumerState<MessagesListSection> createState() =>
      _MessagesListSectionState();
}

class _MessagesListSectionState extends ConsumerState<MessagesListSection> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          ref
              .read(getMessagesByConversationIDUseCaseProvider.notifier)
              .loadedMoreData();
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
    final getMessages = ref.watch(getMessagesByConversationIDUseCaseProvider);
    final getMessagesNotifier =
        ref.watch(getMessagesByConversationIDUseCaseProvider.notifier);

    final messages = getMessages.value ?? [];

    return AsyncValueWidget(
        value: getMessages,
        data: (data) {
          if (messages.isEmpty) {
            return const CenteredMessage("No message yet.");
          }

          return ListView.separated(
              controller: _scrollController,
              reverse: true,
              separatorBuilder: (context, index) {
                return const VerticalSpacer(15);
              },
              itemBuilder: (BuildContext context, int index) {
                if (messages.length == index) {
                  if (!getMessagesNotifier.noItemMore) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColor.primaryColor,
                      ),
                    );
                  } else if (getMessagesNotifier.noItemMore) {
                    return const CenteredMessage('No more items');
                  } else {
                    return const SizedBox.shrink();
                  }
                }

                final message = messages[index];
                return MessageItem(
                  message: message,
                );
              },
              itemCount: messages.length + 1);
        });
  }
}
