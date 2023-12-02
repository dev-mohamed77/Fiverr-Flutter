import 'package:fiverr/core/components/horizontal_spacer.dart';
import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/chat/domain/entity/message_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({super.key, required this.message});

  final MessageDataEntity message;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment:
          message.sender == "user" ? WrapAlignment.end : WrapAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              message.sender == "user"
                  ? CircleAvatar(
                      radius: 23,
                      child: Text(
                        message.user.name.substring(0, 1).toUpperCase(),
                        style: context.titleLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    )
                  : CircleAvatar(
                      radius: 23,
                      backgroundImage: NetworkImage(message.seller.picture),
                    ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          message.sender == "user"
                              ? Text(
                                  message.user.name,
                                  style: context.titleSmall!
                                      .copyWith(fontWeight: FontWeight.bold),
                                )
                              : Text(
                                  message.seller.displayName,
                                  style: context.titleSmall!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                          const HorizontalSpacer(5),
                          Text(
                            DateFormat('hh:mm a')
                                .format(DateTime.parse(message.createdAt)),
                            style: context.bodySmall!
                                .copyWith(color: AppColor.greyColor),
                          ),
                        ],
                      ),
                      Text(
                        message.message,
                        style: context.titleSmall,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
