part of 'chat_bot_message.dart';

class ChatBotMessageMeta {
  final bool active;
  final bool visible;

  const ChatBotMessageMeta(this.active, this.visible);

  const ChatBotMessageMeta.defaults({
    this.active = false,
    this.visible = false,
  });
}
