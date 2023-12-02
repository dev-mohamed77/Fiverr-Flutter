import 'package:fiverr/features/chat/presentation/manager/select_conversation_provider.dart';
import 'package:fiverr/features/chat/presentation/pages/widgets/chat_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.sellerId, required this.sender});
  final String sellerId;
  final String sender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer(
          builder: (BuildContext context, WidgetRef ref, _) {
            final conversation = ref.watch(selectConversationProvider);
            return conversation != null
                ? sender == "user"
                    ? Text(
                        conversation.seller.displayName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    : Text(
                        conversation.user.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                : const SizedBox.shrink();
          },
        ),
      ),
      body: ChatBody(
        sellerId: sellerId,
        sender: sender,
      ),
    );
  }
}
