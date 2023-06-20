import 'package:bond_core/core.dart';

abstract class ChatDataSource<T extends ChatMessageConvertible,
    G extends ChatMetaConvertible> {
  Future<ListMResponse<T, G>> loadMessages(int chatBotId);

  Future<ListMResponse<T, G>> sendMessage(
    Map<String, dynamic> body,
    int chatBotId,
    String? path,
  );
}
