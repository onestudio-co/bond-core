import '../../data/models/chat_message.dart';
import 'package:flutter/material.dart';

import 'chat_view.dart';

class DefaultChatMessageView extends StatelessWidget {
  const DefaultChatMessageView({
    Key? key,
    required this.message,
    required this.decoration,
  }) : super(key: key);

  final ChatMessage message;
  final ChatBubbleDecoration decoration;

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
          message.content??'',
          textWidthBasis: TextWidthBasis.longestLine,
          style: message.type == MessageType.userInput
              ? decoration.userTextStyle
              : decoration.botTextStyle,
        ),
      ],
    );
  }
}
