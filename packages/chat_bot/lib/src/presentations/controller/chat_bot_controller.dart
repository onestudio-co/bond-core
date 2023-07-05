import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';

import '../../data/data_source/chat_bot_data_source.dart';
import '../../data/models/chat_bot_message.dart';

part 'chat_bot_state.dart';

class ChatBotController<T extends ChatBotMessageConvertible> {
  final int chatBotId;
  final ChatDataSource<T> chatService;
  Function(ChatBotState)? onStateChanged;

  ChatBotController({required this.chatBotId, required this.chatService}) {
    loadMessages(chatBotId);
  }

  final messageController = TextEditingController();
  final scrollController = ScrollController();
  final listKey = GlobalKey<AnimatedListState>();

  ChatBotState _state = ChatBotState.initial();

  Future<void> loadMessages(int chatBotId) async {
    _updateState(_state.copyWith(loading: true));
    try {
      final response = await Future.wait(
        [
          chatService.loadMessages(chatBotId),
          chatService.loadQuestions(chatBotId),
        ],
      );
      final chatBotMessages = response
          .map((e) => e.data)
          .expand((element) => element)
          .map((e) => e.toChatBotMessage())
          .groupListsBy((element) => element.key)
          .values
          .toList();
      _updateState(_state.copyWith(messages: chatBotMessages, loading: false));
    } catch (e) {
      _updateState(_state.copyWith(error: e.toString(), loading: false));
    }
  }

  void appendMessage(ChatBotMessage message) async {
    _updateState(_state.copyWith(
      messages: [
        ..._state.messages,
        [message]
      ],
    ));
    messageController.clear();
    await _scrollToBottom();
  }

  void updateAllowedMessage(List<String> allowedMessageKey) async {
    final visibleMessage = _state.visibleMessages;
    _updateState(_state.copyWith(allowedMessage: [
      ..._state.allowedMessage,
      ...allowedMessageKey,
    ]));
    final newVisibleMessage = _state.visibleMessages;

    // Create sets from lists
    final oldMessagesSet = visibleMessage.toSet();
    final newMessagesSet = newVisibleMessage.toSet();

    // Find new messages
    final addedMessages = newMessagesSet.difference(oldMessagesSet).toList();

    for (final message in addedMessages) {
      final index = newVisibleMessage.indexOf(message);
      listKey.currentState?.insertItem(index);
    }

    // Find removed messages
    final removedMessages = oldMessagesSet.difference(newMessagesSet).toList();

    for (final message in removedMessages) {
      final index = visibleMessage.indexOf(message);
      listKey.currentState?.removeItem(
        index,
        (context, animation) => SizedBox(),
      );
    }

    print('Added messages: $addedMessages');
    print('Removed messages: $removedMessages');
    await _scrollToBottom();
  }

  Future<void> _scrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 350));
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void dispose() {
    messageController.dispose();
    scrollController.dispose();
  }

  void _updateState(ChatBotState newState) {
    _state = newState;
    onStateChanged?.call(_state);
  }
}
