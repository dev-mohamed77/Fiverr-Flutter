import 'package:fiverr/core/components/horizontal_spacer.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/inbox/domain/entity/conversation_data_entity.dart';
import 'package:flutter/material.dart';

class ConversationItem extends StatelessWidget {
  const ConversationItem({super.key, required this.conversation, bool? isUser})
      : _isUser = isUser ?? true;

  final ConversationDataEntity conversation;

  final bool _isUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: const BoxDecoration(
        color: AppColor.whiteColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _isUser
              ? CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(conversation.seller.picture),
                )
              : CircleAvatar(
                  radius: 30,
                  child: Text(
                    conversation.user.name.substring(0, 1).toUpperCase(),
                    style: context.titleMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
          const HorizontalSpacer(15),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _isUser
                      ? Text(
                          conversation.seller.displayName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        )
                      : Text(
                          conversation.user.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                  const VerticalSpacer(3),
                  Text(
                    conversation.lastMessage,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.bodySmall,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
