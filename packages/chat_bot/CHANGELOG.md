## 0.0.1+14

* sort chat bot messages by index.

## 0.0.1+13

* refactor title and text in ChatBotMessage model for Fixing ChatBotDefaultMessageView

## 0.0.1+12

* implement appendMessage method
* remove chatViewPadding from ChatBotBubbleDecoration, instead pass padding directly to ChatBotView
* update ChatBotMessageType code, return SizedBox.shrink when message.type ==
  ChatBotMessageType.userInput()

* provide default values activeTextInput & visibleTextInput from ChatBotState.

## 0.0.1+11

* provide default values activeTextInput & visibleTextInput from ChatBotState.

## 0.0.1+10

* fix ChatBotView itemCount read from state.visibleMessages.

## 0.0.1+9

* ChatBotMessageConvertible method `toChatBotMessage` method that returns a ChatBotMessage not
  List<ChatBotMessage>.

## 0.0.1+8

* remove unused generics G code from bond_chat

## 0.0.1+7

* refactor chat message model
* update all files name to start with chat_bot

## 0.0.1+6

* update bond_network dependency.

## 0.0.1+5

* chat_bubble refactor spacing when chat bubble does not have trailing widget

## 0.0.1+4

* chat_view now has padding from chat_bubble_decoration

## 0.0.1+3

* chat_bubble now has optional trailing widget

## 0.0.1+2

* provide default value for title on .
* update file name to default_chat_message_view.dart' insteaf of default_chat_message_bubble.dart;

## 0.0.1+1

* clean chat-bot code.

## 0.0.1

* initial release.