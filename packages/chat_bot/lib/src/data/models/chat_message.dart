import 'package:bond_network/bond_network.dart';

part 'chat_message_convertible.dart';

part 'chat_meta.dart';

part 'choice.dart';

part 'message_rule.dart';

part 'message_sender.dart';

part 'message_type.dart';

class ChatMessage {
  final int id;
  final MessageType type;
  final String? title;
  final String? icon;
  final String? content;
  final String? key;
  final ChatMeta? meta;
  final MessageRule? rules;
  final List<Choice>? choices; // only used if type is MessageType.multiChoice

  const ChatMessage({
    required this.id,
    required this.type,
    this.content,
    this.title,
    this.icon,
    this.key,
    this.choices,
    this.meta,
    this.rules,
  });
}
