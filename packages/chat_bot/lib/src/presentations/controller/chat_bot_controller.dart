import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';

import '../../data/data_source/chat_bot_data_source.dart';
import '../../data/models/chat_bot_message.dart';

part 'chat_bot_state.dart';

typedef ChatBotControllerListener = Function(ChatBotState, ChatBotState);

class ChatBotController<T extends ChatBotMessageConvertible> {
  final int chatBotId;
  final ChatDataSource<T> chatService;
  final List<ChatBotControllerListener> _listeners = [];

  ChatBotController({required this.chatBotId, required this.chatService}) {
    loadMessages(chatBotId);
  }

  final messageController = TextEditingController();
  final scrollController = ScrollController();

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
      _updateState(_state.copyWith(loading: false, messages: chatBotMessages));
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
  }

  void updateAllowedMessage(List<String> allowedMessageKey) async {
    _updateState(_state.copyWith(allowedMessage: [
      ..._state.allowedMessage,
      ...allowedMessageKey,
    ]));
    await scrollToBottom();
  }

  Future<void> scrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 50));
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
    final oldState = _state;
    _state = newState;
    for (final listener in _listeners) {
      listener(oldState, newState);
    }
  }

  void addListener(ChatBotControllerListener listener) {
    _listeners.add(listener);
  }

  void removeListener(ChatBotControllerListener listener) {
    _listeners.remove(listener);
  }
}
