import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';

import '../../data/data_source/chat_bot_data_source.dart';
import '../../data/models/chat_bot_message.dart';

part 'chat_bot_state.dart';

const Duration kMessageAppearDuration = Duration(milliseconds: 800);

typedef ChatBotControllerListener<G extends ChatBotMessage> = Function(
    ChatBotState<G>, ChatBotState<G>);

typedef TransformMessage<G extends ChatBotMessage> = G Function(
  G message,
  int newIndex,
  String newKey,
);

extension ListCondition<T> on Iterable<T> {
  Iterable<T> whereNotIn(Iterable<T> list) =>
      where((element) => !list.contains(element));
}

class ChatBotController<T extends ChatBotMessageConvertible<G>,
    G extends ChatBotMessage> {
  final int chatBotId;
  final ChatDataSource<T> chatService;
  final List<ChatBotControllerListener> _listeners = [];
  final TransformMessage<G> transform;

  ChatBotController({
    required this.chatBotId,
    required this.chatService,
    required this.transform,
  }) {
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
          .map((e) => transform(e, e.index, _retryKey(e.key, 0)))
          .groupListsBy((element) => element.key)
          .values
          .toList();
      _updateState(_state.copyWith(loading: false, messages: chatBotMessages));
    } catch (e) {
      _updateState(_state.copyWith(error: e.toString(), loading: false));
    }
  }

  Future<void> appendMessage(G message) async {
    final retryCount = _state.retryCount;
    _state = _state.copyWith(
      messages: [
        ..._state.messages,
        [
          transform(
            message,
            message.index,
            _retryKey(message.originalKey, retryCount),
          )
        ]
      ],
    );
    messageController.clear();
    await scrollToBottom();
  }

  Future<void> resetFlow(String messageKey) async {
    final newRetryCount = _state.retryCount + 1;
    _state = _state.copyWith(retryCount: newRetryCount);

    final sortedFlatMessages =
        _state.flatMessages.sortedBy<num>((element) => element.index).toList();

    final newFlowIndex = sortedFlatMessages.last.index;

    final allMessages = _state.flatMessages;
    final newAllMessages = allMessages
        .map(
          (element) => transform(
            element,
            newFlowIndex + element.index,
            _retryKey(
              element.originalKey,
              newRetryCount,
            ),
          ),
        )
        .toList();

    allMessages.addAll(newAllMessages);

    final chatBotMessages = allMessages
        .groupListsBy(
          (element) => element.key,
        )
        .values
        .toList();

    _state = _state.copyWith(messages: chatBotMessages);

    await updateAllowedMessage([messageKey]);
  }

  Future<void> updateAllowedMessage(List<String> allowedMessageKey) async {
    final oldChatBotState = _state;
    final previousLength = oldChatBotState.visibleMessages.length;

    final retryCount = oldChatBotState.retryCount;

    final mAllowedMessageKey = allowedMessageKey.map(
      (key) => _retryKey(key, retryCount),
    );

    final flatMessages = _state.flatMessages;

    // Check if all allowedMessageKey items are in flatMessages
    for (final key in mAllowedMessageKey) {
      if (!flatMessages.any((message) => message.key == key)) {
        log('Key $key not found in flatMessages');
        return;
      }
    }

    _updateState(_state.copyWith(allowedMessage: [
      ..._state.allowedMessage,
      ...mAllowedMessageKey,
    ]));

    final newChatBotState = _state;
    final currentLength = newChatBotState.visibleMessages.length;
    await _checkInputView(currentLength, previousLength);
    await scrollToBottom();
  }

  void removeAllowedMessage(List<String> keysToRemove) async {
    // _updateState(
    //   _state.copyWith(
    //     allowedMessage: _state.allowedMessage.whereNotIn(keysToRemove).toList(),
    //   ),
    // );
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
    if (_state.showInputView != showInputView) {
      _updateState(_state.copyWith(showInputView: showInputView));
    }
  }

  void _onFocusChanged() async {
    if (focusNode.hasFocus) {
      await Future.delayed(Duration(milliseconds: 300));
      await scrollToBottom();
    }
  }

  String _retryKey(String key, int retryCount) =>
      '${key}_x_retry_${retryCount}';
}
