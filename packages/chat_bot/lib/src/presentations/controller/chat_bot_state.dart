part of 'chat_bot_controller.dart';

class ChatBotState<G extends ChatBotMessage> {
  final List<List<G>> messages;
  final bool loading;
  final List<String> allowedMessage;
  final String? error;
  final bool showInputView;
  final int retryCount;

  ChatBotState({
    this.messages = const [],
    this.loading = false,
    this.allowedMessage = const [],
    this.error,
    this.showInputView = false,
    this.retryCount = 0, // 0 means no retry
  });

  factory ChatBotState.initial() => ChatBotState();

  List<G> get flatMessages => messages.expand((element) => element).toList();

  List<G> get visibleMessages => flatMessages
      .where((element) => allowedMessage.contains(element.key))
      .sortedBy<num>((element) => element.index)
      .toList();

  ChatBotState<G> copyWith({
    List<List<G>>? messages,
    bool? loading,
    List<String>? allowedMessage,
    String? error,
    bool? showInputView,
    int? retryCount,
  }) {
    return ChatBotState<G>(
      messages: messages ?? this.messages,
      loading: loading ?? this.loading,
      allowedMessage: allowedMessage ?? this.allowedMessage,
      error: error ?? this.error,
      showInputView: showInputView ?? this.showInputView,
      retryCount: retryCount ?? this.retryCount,
    );
  }
}
