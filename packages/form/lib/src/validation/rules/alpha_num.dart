import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

/// A validation rule that checks if a string contains only alphanumeric characters.
///
/// This rule validates that the input string consists of alphanumeric characters (letters and digits) only.
class AlphaNum extends ValidationRule<String> {
  /// Creates a new instance of the [AlphaNum] validation rule.
  ///
  /// - [message]: A custom validation message (optional) to be displayed
  ///   when the validation fails.
  AlphaNum({String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.alphaNumValidationMessage(fieldName);

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value);
  }
}
