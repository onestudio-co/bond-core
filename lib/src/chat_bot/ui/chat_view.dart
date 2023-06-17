import 'package:bond_core/src/chat_bot/controller/chat_controller.dart';
import 'package:bond_core/src/chat_bot/models/chat_message.dart';
import 'package:flutter/widgets.dart';

part 'chat_bubble.dart';

part 'chat_bubble_decoration.dart';

part 'chat_message_builder.dart';

class ChatView extends StatefulWidget {
  final ChatController controller;
  final ChatState state;
  final ChatBubble Function(BuildContext, ChatMessage) bubbleBuilder;
  final Widget typingIndicator;
  final Widget inputView;

  const ChatView({
    Key? key,
    required this.controller,
    required this.bubbleBuilder,
    required this.typingIndicator,
    required this.inputView,
    required this.state,
  }) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    widget.controller.onNewMessages = () {
      Future.delayed(
        const Duration(milliseconds: 500),
        () {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 100),
            curve: Curves.linear,
          );
        },
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            itemCount: widget.state.messages.length,
            itemBuilder: (context, index) {
              return widget.bubbleBuilder(
                  context, widget.state.messages[index]);
            },
          ),
        ),
        if (widget.state.loading) widget.typingIndicator,
        widget.inputView,
      ],
    );
  }
}
