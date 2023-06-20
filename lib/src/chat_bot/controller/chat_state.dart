part of 'chat_controller.dart';

class ChatState {
  final List<ChatMessage> messages;
  final ChatMeta meta;
  final bool loading;
  final String? error;
  final Map<String, String>? pendingAnswers;

  ChatState(
      this.messages, this.meta, this.loading, this.error, this.pendingAnswers);

  factory ChatState.initial() => ChatState(
        [],
        ChatMeta(),
        true,
        null,
        null,
      );

  ChatState copyWith({
    List<ChatMessage>? messages,
    ChatMeta? meta,
    bool? loading,
    String? error,
    Map<String, String>? pendingAnswers,
  }) {
    return ChatState(
      messages ?? this.messages,
      meta ?? this.meta,
      loading ?? this.loading,
      error ?? this.error,
      pendingAnswers ?? this.pendingAnswers,
    );
  }
}
