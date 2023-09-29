import 'package:flutter/widgets.dart';

/// provide helper methods related to the on-screen keyboard.
extension KeyboardContext on BuildContext {
  /// Hides the currently open on-screen keyboard, if any.
  ///
  /// This is especially useful in scenarios where an input field is done being used
  /// and the keyboard needs to be manually dismissed.
  ///
  /// Example usage:
  /// ```dart
  /// context.hideKeyboard();
  /// ```
  void hideKeyboard() {
    FocusScope.of(this).unfocus();
  }

  /// Checks if the on-screen keyboard is currently open.
  ///
  /// This can be handy to adjust UI elements based on the keyboard's visibility.
  ///
  /// Example usage:
  /// ```dart
  /// if (context.keyboardOpened) {
  ///   // Do something when keyboard is open
  /// }
  /// ```
  bool get keyboardOpened => MediaQuery.of(this).viewInsets.bottom != 0;

  /// Opens the on-screen keyboard by focusing on a provided [FocusNode].
  ///
  /// Note: This is useful in scenarios where you want to programmatically trigger
  /// the keyboard to appear, for example when a user taps on a custom input field.
  ///
  /// [focusNode] - The focus node associated with the input where the keyboard needs to be shown.
  ///
  /// Example usage:
  /// ```dart
  /// context.showKeyboard(myFocusNode);
  /// ```
  void showKeyboard(FocusNode focusNode) {
    FocusScope.of(this).requestFocus(focusNode);
  }
}
