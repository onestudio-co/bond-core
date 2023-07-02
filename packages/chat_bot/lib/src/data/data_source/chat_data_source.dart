import 'package:bond_network/bond_network.dart';

import '../models/chat_message.dart';

abstract class ChatDataSource<T extends ChatMessageConvertible,
    G extends ChatMetaConvertible> {
  Future<SingleResponse<T>> loadMessages(int chatBotId);

  Future<SingleResponse<T>> sendTextMessage(
    int chatBotId,
    String text,
  );

  Future<SingleResponse<T>> answerQuestion(
    int chatBotId,
    Map<String, dynamic> body,
  );
}
