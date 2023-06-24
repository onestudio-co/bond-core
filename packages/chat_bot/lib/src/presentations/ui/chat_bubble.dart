part of 'chat_view.dart';

class ChatBubble extends StatelessWidget {
  final int index;
  final ChatMessage message;
  final ChatBubbleDecoration decoration;
  final ChatMessageBuilder chatMessageBuilder;
  final bool? hasLeading;
  final Widget? leading;

  const ChatBubble({
    Key? key,
    required this.index,
    required this.message,
    required this.decoration,
    required this.chatMessageBuilder,
    this.leading,
    this.hasLeading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isUserMessage = message.sender == MessageSender.user;
    final bubbleDecoration =
        isUserMessage ? decoration.userDecoration : decoration.botDecoration;
    final delayAnimationDuration = isUserMessage
        ? decoration.userDelayAnimationDuration
        : decoration.botDelayAnimationDuration;
    return DelayedDisplay(
      delay: Duration(
        milliseconds: delayAnimationDuration.inMilliseconds * index,
      ),
      child: Container(
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
              DefaultChatBubble(
                message: message,
                decoration: decoration,
              ),
        ),
      ),
    );
  }
}
