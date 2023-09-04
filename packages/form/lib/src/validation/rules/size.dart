import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

/// A validation rule that checks if a string has a specified size (length).
///
/// This rule validates that the input string has the specified size (length).
class Size extends ValidationRule<String> {
  /// The required size (length) for the string.
  final int size;

  /// Creates a new instance of the [Size] validation rule.
  ///
  /// - [size]: The required size (length) for the string (required).
  /// - [message]: A custom validation message (optional) to be displayed
  ///   when the validation fails.
  Size(this.size, {String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.sizeValidationMessage(fieldName, size);

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return value.length == size;
  }
}
