import 'package:flutter/material.dart';

import '../../data/models/chat_bot_message.dart';
import 'chat_bot_view.dart';

class ChatBotDefaultMessageView extends StatelessWidget {
  const ChatBotDefaultMessageView({
    Key? key,
    required this.message,
    required this.decoration,
  }) : super(key: key);

  final ChatBotMessage message;
  final ChatBotBubbleDecoration decoration;

  bool get _haveTitle => message.title != null && message.title!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_haveTitle)
          Text(
            message.title ?? '',
            style: decoration.botTitleTextStyle,
          ),
        if (_haveTitle) const SizedBox(height: 12),
        Text(
          message.text ?? '',
          textWidthBasis: TextWidthBasis.longestLine,
          style: message.type == ChatBotMessageSender.user
              ? decoration.userTextStyle
              : decoration.botTextStyle,
        ),
      ],
    );
  }
}
