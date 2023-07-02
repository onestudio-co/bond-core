import 'package:flutter/widgets.dart';
import 'package:collection/collection.dart';

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

  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

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
          .expand((element) => element)
          .groupListsBy((element) => element.key)
          .values
          .toList();
      _updateState(_state.copyWith(messages: chatBotMessages, loading: false));
    } catch (e) {
      _updateState(_state.copyWith(error: e.toString(), loading: false));
    }
  }

  void updateAllowedMessage(List<String> allowedMessageKey) {
    _updateState(_state.copyWith(allowedMessage: allowedMessageKey));
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
