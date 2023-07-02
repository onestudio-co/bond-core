part of 'chat_message.dart';

mixin ChatMessageConvertible on Model {
  ChatMessage toChatMessage();
}

mixin ChatMetaConvertible on Model {
  ChatMeta toChatMeta();
}

mixin ChoiceConvertible on Model {
  Choice toChoice();
}
mixin MessageRuleConvertible on Model {
  MessageRule toMessageRule();
}
