import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/widgets.dart';

import '../../data/models/chat_message.dart';
import '../controller/chat_controller.dart';
import 'default_chat_message_view.dart';

part 'chat_bubble.dart';

part 'chat_bubble_decoration.dart';

part 'chat_message_builder.dart';

class ChatView extends StatefulWidget {
  final ChatController controller;
  final ChatState state;
  final ChatBubble Function(BuildContext, int, ChatMessage) bubbleBuilder;
  final Widget typingIndicator;
  final Widget inputView;
  final ChatBubbleDecoration decoration;

  const ChatView({
    Key? key,
    required this.controller,
    required this.bubbleBuilder,
    required this.typingIndicator,
    required this.inputView,
    required this.state,
    required this.decoration,
  }) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  int chatIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: widget.decoration.chatViewPadding,
            controller: widget.controller.scrollController,
            itemCount: widget.state.messages.length,
            itemBuilder: (context, index) {
              setState(() {
                chatIndex = index;
              });
              return widget.bubbleBuilder(
                  context, index, widget.state.messages[index]);
            },
          ),
        ),
        if (widget.state.loading) widget.typingIndicator,
        Visibility(
          visible: widget.state.messages[chatIndex].meta?.active ?? false,
          child: AbsorbPointer(
            absorbing:
                !(widget.state.messages[chatIndex].meta?.active ?? false),
            child: widget.inputView,
          ),
        ),
      ],
    );
  }
}
