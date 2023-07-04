import 'package:bond_network/bond_network.dart';

import '../models/chat_bot_message.dart';

abstract class ChatDataSource<T extends ChatBotMessageConvertible> {
  Future<ListResponse<T>> loadMessages(int chatBotId);

  Future<ListResponse<T>> loadQuestions(int chatBotId);

  Future<SuccessResponse> answerQuestion({
    required int chatBotId,
    required Map<String, dynamic> body,
  });
}
