part of 'chat_bot_message.dart';

mixin ChatBotMessageHasPadding on ChatBotMessage {
  Map<ChatBotMessageType, EdgeInsets> get padding;
}
