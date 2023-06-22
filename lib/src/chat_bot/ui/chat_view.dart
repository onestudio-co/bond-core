import 'package:bond_core/src/chat_bot/controller/chat_controller.dart';
import 'package:bond_core/src/chat_bot/models/chat_message.dart';
import 'package:bond_core/src/chat_bot/ui/default_chat_bubble.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/widgets.dart';

part 'chat_bubble.dart';

part 'chat_bubble_decoration.dart';

part 'chat_message_builder.dart';

class ChatView extends StatelessWidget {
  final ChatController controller;
  final ChatState state;
  final ChatBubble Function(BuildContext, int, ChatMessage) bubbleBuilder;
  final Widget typingIndicator;
  final Widget inputView;

  const ChatView({
    Key? key,
    required this.controller,
    required this.bubbleBuilder,
    required this.typingIndicator,
    required this.inputView,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> valueNotifier = ValueNotifier<bool>(false);
    Future.delayed(const Duration(milliseconds: 1400), () {
      valueNotifier.value = state.meta.isVisible;
    });

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: controller.scrollController,
            itemCount: state.messages.length,
            itemBuilder: (context, index) {
              return bubbleBuilder(context, index, state.messages[index]);
            },
          ),
        ),
        if (state.loading) typingIndicator,
        ValueListenableBuilder(
          valueListenable: valueNotifier,
          builder: (context, value, child) {
            return Visibility(
              visible: state.meta.isVisible,
              child: AbsorbPointer(
                absorbing: !state.meta.isActive,
                child: inputView,
              ),
            );
          },
        ),
      ],
    );
  }
}
