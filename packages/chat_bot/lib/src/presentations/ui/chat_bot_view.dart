import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/widgets.dart';

import '../../data/models/chat_bot_message.dart';
import '../controller/chat_bot_controller.dart';
import 'chat_bot_default_message_view.dart';

part 'chat_bot_bubble.dart';

part 'chat_bot_bubble_decoration.dart';

part 'chat_bot_message_builder.dart';

class ChatBotView extends StatelessWidget {
  final ChatBotController controller;
  final ChatBotState state;
  final ChatBotBubble Function(BuildContext, int, ChatBotMessage) bubbleBuilder;
  final Widget typingIndicator;
  final Widget inputView;
  final EdgeInsets padding;

  const ChatBotView({
    Key? key,
    required this.controller,
    required this.bubbleBuilder,
    required this.typingIndicator,
    required this.inputView,
    required this.state,
    required this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            key: PageStorageKey('chat_bot'),
            // Helps maintain state across rebuilds
            padding: padding,
            controller: controller.scrollController,
            itemCount: state.visibleMessages.length,
            itemBuilder: (context, index) {
              return bubbleBuilder(
                context,
                index,
                state.visibleMessages[index],
              );
            },
          ),
        ),
        if (state.loading) typingIndicator,
        Visibility(
          visible: state.visibleTextInput,
          child: AbsorbPointer(
            absorbing: !(state.activeTextInput),
            child: inputView,
          ),
        ),
      ],
    );
  }
}
