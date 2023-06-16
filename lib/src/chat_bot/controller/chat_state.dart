part of 'chat_controller.dart';

class ChatState {
  final List<ChatMessage> messages;
  final bool loading;
  final String? error;

  ChatState(this.messages, this.loading, this.error);

  factory ChatState.initial() => ChatState([], false, null);

  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? loading,
    String? error,
  }) {
    return ChatState(
      messages ?? this.messages,
      loading ?? this.loading,
      error ?? this.error,
    );
  }
}
