import 'package:bond_core/core.dart';
import 'package:flutter/cupertino.dart';

part 'chat_state.dart';

class ChatController<T extends ChatMessageConvertible,
    G extends ChatMetaConvertible> {
  final ChatDataSource<T, G> chatService;
  Function(ChatState)? onStateChanged;
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  ChatController(int chatBotId, this.chatService) {
    loadMessages(chatBotId);
  }

  ChatState _state = ChatState.initial();

  Future<void> loadMessages(int chatBotId) async {
    _updateState(_state.copyWith(loading: true));
    try {
      final response = await chatService.loadMessages(chatBotId);
      final chatMessages = response.data.map((e) => e.toChatMessage()).toList();

      _updateState(_state.copyWith(
          messages: chatMessages,
          meta: response.meta.toChatMeta(),
          loading: false));
    } catch (e) {
      _updateState(_state.copyWith(error: e.toString(), loading: false));
    }
  }

  Future<void> sendMessage({
    required int chatBotId,
    Map<String, dynamic>? body,
  }) async {
    final mBody = body ??
        {
          if (messageController.text.trim().isNotEmpty)
            'message': messageController.text.trim(),
          if (_state.pendingAnswers != null) 'answers': _state.pendingAnswers,
        };
    _updateState(_state.copyWith(loading: true));
    try {
      final response = await chatService.sendMessage(mBody, chatBotId);
      final chatMessages = response.data.map((e) => e.toChatMessage()).toList();
      _updateState(_state.copyWith(
          messages: [..._state.messages, ...chatMessages], loading: false));
      Future.delayed(
        const Duration(milliseconds: 500),
        () {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 100),
            curve: Curves.linear,
          );
        },
      );
      messageController.clear();
    } catch (e) {
      _updateState(_state.copyWith(error: e.toString(), loading: false));
    }
  }

  void updatePendingAnswers(Map<String, String>? answers) {
    _state = _state.copyWith(pendingAnswers: answers);
  }

  void dispose() {
    messageController.dispose();
    scrollController.dispose();
  }

  void _updateState(ChatState newState) {
    _state = newState;
    onStateChanged?.call(_state);
  }
}
