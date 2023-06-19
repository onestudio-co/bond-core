import 'package:bond_core/src/network/models/model.dart';

part 'message_sender.dart';

part 'message_type.dart';

part 'chat_message_convertible.dart';

class ChatMessage {
  final int chatBotId;
  final MessageSender sender;
  final MessageType type;
  final String content;
  final List<String>? choices; // only used if type is MessageType.multiChoice

  ChatMessage({
    required this.chatBotId,
    required this.sender,
    required this.type,
    required this.content,
    this.choices,
  });
}
