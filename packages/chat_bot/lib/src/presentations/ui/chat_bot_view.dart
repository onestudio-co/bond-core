import 'dart:developer';

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

  ChatBotView({
    Key? key,
    required this.controller,
    required this.bubbleBuilder,
    required this.typingIndicator,
    required this.inputView,
    required this.state,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            key: controller.listKey,
            padding: padding,
            controller: controller.scrollController,
            // initialItemCount: state.visibleMessages.length,
            itemCount: state.visibleMessages.length,
            itemBuilder: (context, index) {
              return bubbleBuilder(
                context,
                index,
                state.visibleMessages[index],
              );
              // return FadeTransition(
              //   opacity: animation,
              //   child: bubbleBuilder(
              //     context,
              //     index,
              //     state.visibleMessages[index],
              //   ),
              // );
            },
          ),
        ),
        typingIndicator,
        Visibility(
          visible: state.showInputView,
          child: inputView,
        ),
      ],
    );
  }
}
