part of 'chat_bot_message.dart';

mixin ChatBotMessageConvertible on Model {
  List<ChatBotMessage> toChatBotMessage();
}

mixin ChatBotMessageMetaConvertible on Model {
  ChatBotMessageMeta toChatBotMessageMeta();
}

mixin ChatBotMessageOptionConvertible on Model {
  ChatBotMessageOption toChatBotMessageOption();
}
