import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

/// A validation rule that checks if a string contains only alphabetic characters.
///
/// This rule validates that the input string consists of alphabetic characters (letters) only.
class Alpha extends ValidationRule<String> {
  /// Creates a new instance of the [Alpha] validation rule.
  ///
  /// - [message]: A custom validation message (optional).
  Alpha({String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.alphaValidationMessage(fieldName);

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return RegExp(r'^[a-zA-Z]+$').hasMatch(value);
  }
}
