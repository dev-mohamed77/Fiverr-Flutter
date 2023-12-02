import 'package:fiverr/core/components/horizontal_spacer.dart';
import 'package:fiverr/core/extension/responsive_size_extensions.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/chat/presentation/manager/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatTextFieldAndButtonSection extends ConsumerWidget {
  const ChatTextFieldAndButtonSection({
    super.key,
    required this.sellerId,
    required this.sender,
    required this.textEditingController,
  });

  final String sellerId;
  final String sender;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: context.width,
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 7),
      decoration: const BoxDecoration(color: AppColor.whiteColor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextFormField(
              controller: textEditingController,
              maxLines: 5,
              minLines: 1,
              decoration: const InputDecoration(
                hintText: "Type a message ...",
                border: InputBorder.none,
              ),
            ),
          ),
          const HorizontalSpacer(5),
          InkWell(
            onTap: () {
              ref
                  .read(getMessagesByConversationIDUseCaseProvider.notifier)
                  .sendMessage(
                    sellerId: sellerId,
                    sender: sender,
                    message: textEditingController.text,
                    textEditingController: textEditingController,
                  );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              child: Icon(
                Icons.send_outlined,
                size: 40,
                color: AppColor.primaryColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
