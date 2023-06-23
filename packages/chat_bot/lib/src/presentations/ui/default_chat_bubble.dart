import 'package:bond_chat_bot/src/data/models/chat_message.dart';
import 'package:flutter/material.dart';

import 'chat_view.dart';

class DefaultChatBubble extends StatelessWidget {
  const DefaultChatBubble({
    Key? key,
    required this.message,
    required this.decoration,
    required this.isUserMessage,
  }) : super(key: key);

  final ChatMessage message;
  final ChatBubbleDecoration decoration;
  final bool isUserMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: message.title != null,
          child: Text(
            message.title ?? '',
            style: decoration.botTitleTextStyle,
          ),
        ),
        Visibility(
          visible: message.title != null,
          child: const SizedBox(
            height: 12,
          ),
        ),
        Text(
          message.content,
          style: isUserMessage
              ? decoration.userTextStyle
              : decoration.botTextStyle,
        ),
      ],
    );
  }
}
