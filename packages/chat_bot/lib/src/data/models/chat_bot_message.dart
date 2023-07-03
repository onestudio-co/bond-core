import 'package:bond_network/bond_network.dart';

part 'chat_bot_message_convertible.dart';

part 'chat_bot_message_option.dart';

part 'chat_bot_message_sender.dart';

part 'chat_bot_message_meta.dart';

part 'chat_bot_message_type.dart';

abstract class ChatBotMessage {
  final int id;
  final int index;
  final ChatBotMessageType type;
  final ChatBotMessageSender sender;
  final String key;
  final String? text;
  final String? title;
  final String? icon;
  final ChatBotMessageMeta meta;
  final List<ChatBotMessageOption> options;

  const ChatBotMessage({
    required this.id,
    required this.index,
    required this.type,
    required this.sender,
    required this.key,
    this.title,
    this.text,
    this.icon,
    this.meta = const ChatBotMessageMeta.defaults(),
    this.options = const [],
  });
}
