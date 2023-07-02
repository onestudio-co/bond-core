part of 'chat_message.dart';

enum MessageType {
  text, // a plain text message
  userInput, // FOR user input messages
  multiChoice, // a question that requires selecting an answer from multiple choices
  stepper, // a question that requires selecting a value from a range of values
  ad, // a plain text message with button to show ad
}
