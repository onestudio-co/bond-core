part of 'chat_controller.dart';

class ChatState {
  final List<ChatMessage> messages;
  final bool loading;
  final String? error;
  final Map<String, String>? pendingAnswers;

  ChatState(this.messages, this.loading, this.error, this.pendingAnswers);

  factory ChatState.initial() => ChatState(
        [],
        true,
        null,
        null,
      );

  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? loading,
    String? error,
    Map<String, String>? pendingAnswers,
  }) {
    return ChatState(
      messages ?? this.messages,
      loading ?? this.loading,
      error ?? this.error,
      pendingAnswers ?? this.pendingAnswers,
    );
  }
}
