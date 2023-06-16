part of 'chat_message.dart';

enum MessageType {
  text,        // a plain text message
  question,    // a question that requires a textual answer
  multiChoice, // a question that requires selecting an answer from multiple choices
}