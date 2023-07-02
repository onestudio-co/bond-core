import '../../../bond_chat_bot.dart';

class ChatData {
  final List<ChatMessage>? welcomeMessages;
  final ChatMessage? userInput;
  final ChatMessage? thanksEnterUserInput;
  final List<ChatMessage>? skipQuestions;
  final List<ChatMessage>? optionalQuestions;
  final List<ChatMessage>? watchAd;

  const ChatData({
    this.welcomeMessages,
    this.userInput,
    this.thanksEnterUserInput,
    this.skipQuestions,
    this.optionalQuestions,
    this.watchAd,
  });
  List<ChatMessage> convertToChatMessages() {
    var chatMessages = <ChatMessage>[];

    // Add welcome messages
    if (welcomeMessages != null) {
      for (final message in welcomeMessages!) {
        chatMessages.add(ChatMessage(
          id: message.id,
          type: MessageType.text,
          title: message.title,
          icon: message.icon,
          content: message.content,
          key: message.key,
          meta: message.meta,
          rules: message.rules,
          choices: message.choices,
        ));
      }
    }

    // Add user input message
    if (userInput != null) {
      chatMessages.add(ChatMessage(
        id: userInput!.id,
        type: MessageType.userInput,
        title: userInput!.title,
        icon: userInput!.icon,
        content: userInput!.content,
        key: userInput!.key,
        meta: userInput!.meta,
        rules: userInput!.rules,
        choices: userInput!.choices,
      ));
    }

    // Add thanks enter user input message
    if (thanksEnterUserInput != null) {
      chatMessages.add(ChatMessage(
        id: thanksEnterUserInput!.id,
        type: MessageType.text,
        title: thanksEnterUserInput!.title,
        icon: thanksEnterUserInput!.icon,
        content: thanksEnterUserInput!.content,
        key: thanksEnterUserInput!.key,
        meta: thanksEnterUserInput!.meta,
        rules: thanksEnterUserInput!.rules,
        choices: thanksEnterUserInput!.choices,
      ));
    }

    // Add skip questions messages
    if (skipQuestions != null) {
      for (final message in skipQuestions!) {
        chatMessages.add(ChatMessage(
          id: message.id,
          type: MessageType.text,
          title: message.title,
          icon: message.icon,
          content: message.content,
          key: message.key,
          meta: message.meta,
          rules: message.rules,
          choices: message.choices,
        ));
      }
    }

    // Add optional questions messages
    if (optionalQuestions != null) {
      for (final message in optionalQuestions!) {
        chatMessages.add(ChatMessage(
          id: message.id,
          type: MessageType.multiChoice,
          title: message.title,
          icon: message.icon,
          content: message.content,
          key: message.key,
          meta: message.meta,
          rules: message.rules,
          choices: message.choices,
        ));
      }
    }

    // Add watch ad messages
    if (watchAd != null) {
      for (final message in watchAd!) {
        chatMessages.add(ChatMessage(
          id: message.id,
          type: MessageType.ad,
          title: message.title,
          icon: message.icon,
          content: message.content,
          key: message.key,
          meta: message.meta,
          rules: message.rules,
          choices: message.choices,
        ));
      }
    }

    return chatMessages;
  }
}
