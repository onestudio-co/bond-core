part of 'chat_view.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final ChatBubbleDecoration decoration;
  final ChatMessageBuilder chatMessageBuilder;

  const ChatBubble({
    Key? key,
    required this.message,
    required this.decoration,
    required this.chatMessageBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isUserMessage = message.sender == MessageSender.user;
    final bubbleDecoration =
        isUserMessage ? decoration.userDecoration : decoration.botDecoration;
    return Container(
      margin: decoration.margin,
      width: double.infinity,
      alignment: isUserMessage ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: decoration.maxWidth,
          minWidth: decoration.minWidth,
        ),
        padding: decoration.padding,
        decoration: BoxDecoration(
          color: bubbleDecoration.color,
          borderRadius: bubbleDecoration.borderRadius,
        ),
        child: chatMessageBuilder.build(message) ??
            Text(
              message.content,
              style: isUserMessage
                  ? decoration.userTextStyle
                  : decoration.botTextStyle,
            ),
      ),
    );
  }
}
