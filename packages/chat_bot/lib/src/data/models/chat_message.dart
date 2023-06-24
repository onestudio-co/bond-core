import 'package:bond_network/bond_network.dart';

part 'chat_message_convertible.dart';

part 'chat_meta.dart';

part 'message_sender.dart';

part 'message_type.dart';

part 'choice.dart';

class ChatMessage {
  final int chatBotId;
  final int id;
  final MessageSender sender;
  final MessageType type;
  final String? title;
  final String? icon;
  final String content;
  final String? key;
  final List<Choice>? choices; // only used if type is MessageType.multiChoice

  const ChatMessage({
    required this.id,
    required this.chatBotId,
    required this.sender,
    required this.type,
    this.title,
    this.icon,
    required this.content,
    this.key,
    this.choices,
  });
}
