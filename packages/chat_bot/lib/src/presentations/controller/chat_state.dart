part of 'chat_controller.dart';

class ChatState {
  final List<ChatMessage> messages;
  final ChatMeta meta;
  final bool loading;
  final String? error;

  ChatState(this.messages, this.meta, this.loading, this.error);

  factory ChatState.initial() => ChatState(
        [],
        ChatMeta(),
        true,
        null,
      );

  ChatState copyWith({
    List<ChatMessage>? messages,
    ChatMeta? meta,
    bool? loading,
    String? error,
  }) {
    return ChatState(
      messages ?? this.messages,
      meta ?? this.meta,
      loading ?? this.loading,
      error ?? this.error,
    );
  }
}
