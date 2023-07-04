part of 'chat_bot_message.dart';

// extends this class to create a new message type
class ChatBotMessageType {
  final String _value;

  ChatBotMessageType(this._value);

  factory ChatBotMessageType.text() => ChatBotMessageType('text');

  factory ChatBotMessageType.userInput() => ChatBotMessageType('user_input');

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatBotMessageType && other._value == _value;
  }

  @override
  int get hashCode => _value.hashCode;
}
