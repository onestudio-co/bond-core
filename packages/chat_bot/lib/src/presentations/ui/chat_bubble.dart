part of 'chat_view.dart';

class ChatBubble extends StatelessWidget {
  final int index;
  final ChatMessage message;
  final ChatBubbleDecoration decoration;
  final ChatMessageBuilder chatMessageBuilder;
  final Widget? trailing;

  const ChatBubble({
    Key? key,
    required this.index,
    required this.message,
    required this.decoration,
    required this.chatMessageBuilder,
    this.trailing,
  }) : super(key: key);

  bool get _hasTrailing => trailing != null;

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
        margin: isUserMessage ? decoration.userMargin : decoration.botMargin,
        width: double.infinity,
        alignment: isUserMessage ? Alignment.topRight : Alignment.topLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
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
                  DefaultChatMessageView(
                    message: message,
                    decoration: decoration,
                  ),
            ),
            Visibility(
              visible: _hasTrailing,
              child: const SizedBox(width: 4),
            ),
            Visibility(
              visible: _hasTrailing,
              child: trailing ?? SizedBox.shrink(),
            )
          ],
        ),
      ),
    );
  }
}
