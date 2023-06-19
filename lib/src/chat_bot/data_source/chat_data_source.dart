import 'package:bond_core/src/network/models.dart';

import '../models/chat_message.dart';

abstract class ChatDataSource<T extends ChatMessageConvertible> {
  Future<ListResponse<T>> loadMessages(int chatBotId);

  Future<ListResponse<T>> sendMessage(Map<String, dynamic> body, int chatBotId);
}
