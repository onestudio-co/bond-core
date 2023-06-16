import 'package:bond_core/src/chat_bot/data_source/chat_data_source.dart';
import 'package:bond_core/src/chat_bot/models/chat_message.dart';

part 'chat_state.dart';

class ChatController<T extends ChatMessageConvertible> {
  final ChatDataSource<T> chatService;
  Function(ChatState)? onStateChanged;

  ChatController(int chatBotId, this.chatService) {
    loadMessages(chatBotId);
  }

  ChatState _state = ChatState.initial();

  Future<void> loadMessages(int chatBotId) async {
    _updateState(_state.copyWith(loading: true));
    try {
      final response = await chatService.loadMessages(chatBotId);
      final chatMessages = response.data.map((e) => e.toChatMessage()).toList();
      _updateState(_state.copyWith(messages: chatMessages, loading: false));
    } catch (e) {
      _updateState(_state.copyWith(error: e.toString(), loading: false));
    }
  }

  Future<void> sendMessage(Map<String, dynamic> body) async {
    try {
      final response = await chatService.sendMessage(body);
      final chatMessages = response.data.map((e) => e.toChatMessage()).toList();
      _updateState(
          _state.copyWith(messages: [..._state.messages, ...chatMessages]));
    } catch (e) {
      _updateState(_state.copyWith(error: e.toString()));
    }
  }

  void _updateState(ChatState newState) {
    _state = newState;
    onStateChanged?.call(_state);
  }
}
