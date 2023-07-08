import 'package:flutter/widgets.dart';

import '../../data/models/chat_bot_message.dart';
import '../controller/chat_bot_controller.dart';
import 'chat_bot_default_message_view.dart';

part 'chat_bot_bubble.dart';

part 'chat_bot_bubble_decoration.dart';

part 'chat_bot_message_builder.dart';

class ChatBotView extends StatefulWidget {
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
  State<ChatBotView> createState() => _ChatBotViewState();
}

class _ChatBotViewState extends State<ChatBotView> {
  final _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    widget.controller.addListener(_onStateChanged);
    super.initState();
  }

  void dispose() {
    widget.controller.removeListener(_onStateChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: AnimatedList(
            key: _listKey,
            padding: widget.padding,
            controller: widget.controller.scrollController,
            initialItemCount: widget.state.visibleMessages.length,
            itemBuilder: (context, index, animation) {
              return FadeTransition(
                opacity: animation,
                child: widget.bubbleBuilder(
                  context,
                  index,
                  widget.state.visibleMessages[index],
                ),
              );
            },
          ),
        ),
        widget.typingIndicator,
        Visibility(
          visible: widget.state.showInputView,
          child: widget.inputView,
        ),
      ],
    );
  }

  void _onStateChanged(
      ChatBotState oldChatBotState, ChatBotState newChatBotState) async {
    final currentLength = newChatBotState.visibleMessages.length;
    final previousLength = oldChatBotState.visibleMessages.length;
    if (currentLength > previousLength) {
      final numAdded = currentLength - previousLength;
      for (var i = 0; i < numAdded; i++) {
        await Future.delayed(kMessageAppearDuration);
        _listKey.currentState!.insertItem(previousLength + i);
      }
      await widget.controller.scrollToBottom();
    }
  }
}
