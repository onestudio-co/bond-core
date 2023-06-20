import 'package:bond_core/core.dart';

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
