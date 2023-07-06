part of 'chat_bot_view.dart';

abstract class ChatMessageBuilder<G extends ChatBotMessage> {
  Widget? build(G message);
}
