part of 'chat_bot_view.dart';

class ChatBotBubble extends StatelessWidget {
  final int index;
  final ChatBotMessage message;
  final ChatBotBubbleDecoration decoration;
  final ChatMessageBuilder chatMessageBuilder;
  final Widget? trailing;

  const ChatBotBubble({
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
    if (message.type == ChatBotMessageType.userInput()) {
      return SizedBox.shrink();
    }
    final isUserMessage = message.sender == ChatBotMessageSender.user;
    final bubbleDecoration =
        isUserMessage ? decoration.userDecoration : decoration.botDecoration;
    final chatBotMessageDelay = message is ChatBotMessageHasDelay
        ? (message as ChatBotMessageHasDelay).delay
        : Duration.zero;
    return DelayedDisplay(
      delay: chatBotMessageDelay,
      fadingDuration: chatBotMessageDelay,
      slidingBeginOffset: Offset.zero,
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
                  ChatBotDefaultMessageView(
                    message: message,
                    decoration: decoration,
                  ),
            ),
            Visibility(
                visible: !_hasTrailing,
                child: const SizedBox(
                  width: 28,
                )),
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
