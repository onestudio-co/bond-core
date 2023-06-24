import '../../data/models/chat_message.dart';
import 'package:flutter/material.dart';

import 'chat_view.dart';

class DefaultChatBubble extends StatelessWidget {
  const DefaultChatBubble({
    Key? key,
    required this.message,
    required this.decoration,
  }) : super(key: key);

  final ChatMessage message;
  final ChatBubbleDecoration decoration;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: message.title != null && message.title!.isNotEmpty,
          child: Text(
            message.title!,
            style: decoration.botTitleTextStyle,
          ),
        ),
        Visibility(
          visible: message.title != null && message.title!.isNotEmpty,
          child: const SizedBox(height: 12),
        ),
        Text(
          message.content,
          style: message.sender == MessageSender.user
              ? decoration.userTextStyle
              : decoration.botTextStyle,
        ),
      ],
    );
  }
}
