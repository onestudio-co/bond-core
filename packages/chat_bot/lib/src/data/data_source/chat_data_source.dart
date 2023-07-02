import 'package:bond_network/bond_network.dart';

import '../models/chat_message.dart';

abstract class ChatDataSource<T extends ChatMessageConvertible,
    G extends ChatMetaConvertible> {
  Future<ListMResponse<T, G>> loadMessages(int chatBotId);

  Future<ListMResponse<T, G>> sendTextMessage(
    int chatBotId,
    String text,
  );

  Future<ListMResponse<T, G>> answerQuestion(
    int chatBotId,
    Map<String, dynamic> body,
  );
}
