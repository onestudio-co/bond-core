part of 'chat_bot_controller.dart';

class ChatBotState {
  final List<List<ChatBotMessage>> messages;
  final bool loading;
  final List<String> allowedMessage;
  final String? error;

  ChatBotState({
    this.messages = const [],
    this.loading = false,
    this.allowedMessage = const [],
    this.error,
  });

  factory ChatBotState.initial() => ChatBotState();

  List<ChatBotMessage> get visibleMessages => messages
      .expand((element) => element)
      .where((element) => allowedMessage.contains(element.key))
      .toList();

  bool get visibleTextInput => visibleMessages.last.meta.visible;

  bool get activeTextInput => visibleMessages.last.meta.active;

  ChatBotState copyWith({
    List<List<ChatBotMessage>>? messages,
    bool? loading,
    List<String>? allowedMessage,
    String? error,
  }) {
    return ChatBotState(
      messages: messages ?? this.messages,
      loading: loading ?? this.loading,
      allowedMessage: allowedMessage ?? this.allowedMessage,
      error: error ?? this.error,
    );
  }
}
