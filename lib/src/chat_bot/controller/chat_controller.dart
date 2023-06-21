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

  Future<void> sendTextMessage({
    required int chatBotId,
    String? path,
  }) async {
    final text = messageController.text;
    // Create a temporary message to display immediately.
    final tempMessage = ChatMessage(
      chatBotId: chatBotId,
      id: 0,
      // Use a temporary id, like 0
      content: text,
      type: MessageType.text,
      sender: MessageSender.user,
    );
    // Add the temporary message to the state.
    _updateState(_state.copyWith(messages: [..._state.messages, tempMessage]));
    _resetChat();
    try {
      Future.delayed(const Duration(milliseconds: 1500));
      _updateState(_state.copyWith(loading: true));
      final response = await chatService.sendTextMessage(chatBotId, text, path);
      final chatMessages = response.data.map((e) => e.toChatMessage()).toList();
      _updateState(_state.copyWith(
          messages: [..._state.messages, ...chatMessages], loading: false));
    } catch (e) {
      _updateState(_state.copyWith(error: e.toString(), loading: false));
    }
  }

  Future<void> answerQuestion({
    required int chatBotId,
    required Map<String, dynamic> body,
    String? path,
  }) async {
    _updateState(_state.copyWith(loading: true));
    try {
      final response = await chatService.answerQuestion(chatBotId, body, path);
      final chatMessages = response.data.map((e) => e.toChatMessage()).toList();
      _updateState(_state.copyWith(
        messages: [..._state.messages, ...chatMessages],
        loading: false,
      ));
      _resetChat();
    } catch (e) {
      _updateState(_state.copyWith(error: e.toString(), loading: false));
    }
  }

  void dispose() {
    messageController.dispose();
    scrollController.dispose();
  }

  void _updateState(ChatState newState) {
    _state = newState;
    onStateChanged?.call(_state);
  }

  void _resetChat() {
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
  }
}
