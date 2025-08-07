import 'package:bond_form/bond_form.dart';
import 'package:flutter/widgets.dart' as widgets;

/// A collection of utilities to work with [TextFieldState] inside [BaseFormController].
///
/// This extension provides access to the `TextEditingController` for a field,
/// ensures it's observed for changes, and allows safe disposal of listeners.

extension TextFieldFormController on BaseFormController {
  /// Retrieves the [TextEditingController] for a given text field and ensures it is observed.
  ///
  /// If a listener hasn't been registered for the given [fieldName], this method
  /// will add one that automatically updates the form state when the controller's text changes.
  ///
  /// - Parameter [fieldName]: The name of the text field to observe.
  /// - Returns: The [TextEditingController] associated with the given [fieldName].
  widgets.TextEditingController textFieldController(String fieldName) {
    final field = state.textField(fieldName);
    _observeTextField(fieldName, field.controller);
    return field.controller;
  }

  /// Adds a listener to the [TextEditingController] of the specified field to update form state.
  ///
  /// This ensures that any user input is reflected in the form state via [updateValue].
  /// If a listener has already been registered for the [fieldName], this method does nothing.
  ///
  /// - Parameters:
  ///   - [fieldName]: The name of the text field to bind.
  ///   - [controller]: The [TextEditingController] instance to observe.
  void _observeTextField(
      String fieldName, widgets.TextEditingController controller) {
    if (textFieldListeners.containsKey(fieldName)) return;

    final listener = () {
      updateValue<TextFieldState, String?>(fieldName, controller.text);
    };

    textFieldListeners[fieldName] = listener;
    controller.addListener(listener);
  }

  /// Remove the listener registered for the given text field, if any.
  ///
  /// This is useful when cleaning up resources, such as during `onClose()` in a controller.
  ///
  /// - Parameter [fieldName]: The name of the text field to unbind.
  void removeTextFieldListener(String fieldName) {
    final listener = textFieldListeners.remove(fieldName);
    if (listener != null) {
      final controller = state.textField(fieldName).controller;
      controller.removeListener(listener);
    }
  }
}
