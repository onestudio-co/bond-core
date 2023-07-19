import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';

import '../../data/data_source/chat_bot_data_source.dart';
import '../../data/models/chat_bot_message.dart';

part 'chat_bot_state.dart';

const Duration kMessageAppearDuration = Duration(milliseconds: 800);

typedef ChatBotControllerListener<G extends ChatBotMessage> = Function(
    ChatBotState<G>, ChatBotState<G>);

extension ListCondition<T> on Iterable<T> {
  Iterable<T> whereNotIn(Iterable<T> list) =>
      where((element) => !list.contains(element));
}

class ChatBotController<T extends ChatBotMessageConvertible<G>,
    G extends ChatBotMessage> {
  final int chatBotId;
  final ChatDataSource<T> chatService;
  final List<ChatBotControllerListener> _listeners = [];

  ChatBotController({required this.chatBotId, required this.chatService}) {
    loadMessages(chatBotId);
    focusNode.addListener(_onFocusChanged);
  }

  final messageController = TextEditingController();
  final scrollController = ScrollController();
  final focusNode = FocusNode();

  ChatBotState<G> _state = ChatBotState<G>.initial();

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

  void appendMessage(G message) async {
    final messageAddedBefore = _state.flatMessages
            .firstWhereOrNull((element) => element.key == message.key) !=
        null;
    if (messageAddedBefore) {
      cloneMessage(message.key);
    } else {
      _updateState(_state.copyWith(
        messages: [
          ..._state.messages,
          [message]
        ],
      ));
      messageController.clear();
      await scrollToBottom();
    }
  }

  void cloneMessage(String messageKey) {
    final oldChatBotState = _state;
    final message = oldChatBotState.flatMessages
        .firstWhereOrNull((element) => element.key == messageKey);
    final messageAddedBefore = message != null;
    if (messageAddedBefore) {
      final newIndex = oldChatBotState.visibleMessages.length + 1;
      final newKey = '${message.key}_${newIndex}';
      message.index = newIndex;
      message.key = newKey;
      _state = _state.copyWith(
        messages: [
          ..._state.messages,
          [message]
        ],
      );
      updateAllowedMessage([newKey]);
    }
  }

  void updateAllowedMessage(List<String> allowedMessageKey) async {
    final oldChatBotState = _state;
    final previousLength = oldChatBotState.visibleMessages.length;
    _updateState(_state.copyWith(allowedMessage: [
      ..._state.allowedMessage,
      ...allowedMessageKey,
    ]));
    final newChatBotState = _state;
    final currentLength = newChatBotState.visibleMessages.length;
    await _checkInputView(currentLength, previousLength);
    await scrollToBottom();
  }

  void removeAllowedMessage(List<String> keysToRemove) async {
    _updateState(
      _state.copyWith(
        allowedMessage: _state.allowedMessage.whereNotIn(keysToRemove).toList(),
      ),
    );
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
    focusNode.removeListener(_onFocusChanged);
    focusNode.dispose();
  }

  void _updateState(ChatBotState<G> newState) {
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

  Future<void> _checkInputView(int currentLength, int previousLength) async {
    final showInputView =
        _state.visibleMessages.lastOrNull?.meta.visible ?? false;
    if (showInputView) {
      final numAdded = currentLength - previousLength;
      await Future.delayed(kMessageAppearDuration * numAdded);
      focusNode.requestFocus();
    }
    _updateState(_state.copyWith(showInputView: showInputView));
  }

  void _onFocusChanged() async {
    if (focusNode.hasFocus) {
      await Future.delayed(Duration(milliseconds: 300));
      await scrollToBottom();
    }
  }
}
