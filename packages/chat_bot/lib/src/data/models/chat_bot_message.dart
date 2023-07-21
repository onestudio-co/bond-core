import 'package:bond_network/bond_network.dart';
import 'package:flutter/widgets.dart';

part 'chat_bot_message_convertible.dart';

part 'chat_bot_message_has_padding.dart';

part 'chat_bot_message_meta.dart';

part 'chat_bot_message_option.dart';

part 'chat_bot_message_sender.dart';

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

  ChatBotMessage({
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

  String get originalKey => key.replaceAll(RegExp(r'_x_retry_\d+'), '');
}
