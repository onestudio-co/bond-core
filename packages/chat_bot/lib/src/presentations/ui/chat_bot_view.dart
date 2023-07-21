import 'dart:developer';

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
      await _addMessages(previousLength, currentLength);
    } else if (currentLength < previousLength) {
      //   await _removeMessages(oldChatBotState, newChatBotState);
    }
    await widget.controller.scrollToBottom();
  }

  Future<void> _addMessages(int previousLength, int currentLength) async {
    final numAdded = currentLength - previousLength;
    for (var i = 0; i < numAdded; i++) {
      log('DEBUG LOG - previousLength: $previousLength,'
          ' currentLength: $currentLength,'
          ' i: ${previousLength + i},'); // Add this line to debug
      await Future.delayed(kMessageAppearDuration);
      try {
        _listKey.currentState!.insertItem(previousLength + i);
      } catch (e, stackTrace) {
        log('Error: $e', stackTrace: stackTrace);
      }
    }
  }

  Future<void> _removeMessages(
      ChatBotState oldChatBotState, ChatBotState newChatBotState) async {
    // final oldMessages = List.from(oldChatBotState.visibleMessages);
    // final newMessages = newChatBotState.visibleMessages;
    //
    // final oldMessageIds = oldMessages.map((m) => m.id).toSet();
    // final newMessageIds = newMessages.map((m) => m.id).toSet();
    //
    // final removedMessageIds = oldMessageIds.difference(newMessageIds);
    //
    // for (final removedId in removedMessageIds) {
    //   await Future.delayed(kMessageAppearDuration);
    //   final indexToRemove = oldMessages.indexWhere((m) => m.id == removedId);
    //   log('Removing message at index $indexToRemove');
    //   if (indexToRemove != -1) {
    //     _listKey.currentState!.removeItem(
    //       indexToRemove,
    //       (context, animation) => FadeTransition(
    //         opacity: animation,
    //         child: widget.bubbleBuilder(
    //           context,
    //           indexToRemove,
    //           oldMessages[indexToRemove],
    //         ),
    //       ),
    //     );
    //     oldMessages.removeAt(indexToRemove);
    //   }
    // }
  }
}
