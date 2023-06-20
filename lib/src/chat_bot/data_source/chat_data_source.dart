import 'package:bond_core/core.dart';
import 'package:bond_core/src/network/models/list_m_response.dart';

import '../models/chat_message.dart';

abstract class ChatDataSource<T extends ChatMessageConvertible> {
  Future<ListMResponse<T,Jsonable>> loadMessages(int chatBotId);

  Future<ListMResponse<T,Jsonable>> sendMessage(Map<String, dynamic> body, int chatBotId);
}
