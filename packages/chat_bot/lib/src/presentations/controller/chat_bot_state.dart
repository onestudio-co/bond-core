part of 'chat_bot_controller.dart';

class ChatBotState<G extends ChatBotMessage> {
  final List<List<G>> messages;
  final bool loading;
  final List<String> allowedMessage;
  final String? error;
  final bool showInputView;

  ChatBotState({
    this.messages = const [],
    this.loading = false,
    this.allowedMessage = const [],
    this.error,
    this.showInputView = false,
  });

  factory ChatBotState.initial() => ChatBotState();

  List<G> get visibleMessages => messages
      .expand((element) => element)
      .where((element) => allowedMessage.contains(element.key))
      .sortedBy<num>((element) => element.index)
      .toList();

  ChatBotState<G> copyWith({
    List<List<G>>? messages,
    bool? loading,
    List<String>? allowedMessage,
    List<G>? removedMessages,
    String? error,
    bool? showInputView,
  }) {
    return ChatBotState<G>(
      messages: messages ?? this.messages,
      loading: loading ?? this.loading,
      allowedMessage: allowedMessage ?? this.allowedMessage,
      error: error ?? this.error,
      showInputView: showInputView ?? this.showInputView,
    );
  }
}
