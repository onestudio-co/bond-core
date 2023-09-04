import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

/// A validation rule that checks if a string contains a specific number of digits.
///
/// This rule validates that the input string contains exactly the specified number of digits.
class Digits extends ValidationRule<String> {
  /// The required number of digits in the string.
  final int digitLength;

  /// Creates a new instance of the [Digits] validation rule.
  ///
  /// - [digitLength]: The required number of digits (required).
  /// - [message]: A custom validation message (optional) to be displayed
  ///   when the validation fails.
  Digits(this.digitLength, {String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.digitsValidationMessage(fieldName, digitLength);

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return RegExp('^\\d{$digitLength}\$').hasMatch(value);
  }
}
