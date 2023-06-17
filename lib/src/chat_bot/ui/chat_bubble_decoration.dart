part of 'chat_view.dart';

abstract class ChatBubbleDecoration {
  EdgeInsets get padding;

  EdgeInsets get margin;

  BoxDecoration get userDecoration;

  BoxDecoration get botDecoration;
}
