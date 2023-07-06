part of 'chat_bot_message.dart';

mixin ChatBotMessageConvertible<G extends ChatBotMessage> on Model {
  G toChatBotMessage();
}
