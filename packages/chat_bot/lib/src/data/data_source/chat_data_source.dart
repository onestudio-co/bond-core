import 'package:bond_network/network.dart';

import 'package:bond_chat_bot/src/data/models/chat_message.dart';

abstract class ChatDataSource<T extends ChatMessageConvertible,
    G extends ChatMetaConvertible> {
  Future<ListMResponse<T, G>> loadMessages(int chatBotId);

  Future<ListMResponse<T, G>> sendTextMessage(
    int chatBotId,
    String text,
    String? path,
  );

  Future<ListMResponse<T, G>> answerQuestion(
    int chatBotId,
    Map<String, dynamic> body,
    String? path,
  );
}
