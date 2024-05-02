import 'package:bond_form/src/form_fields/form_field_state.dart';
import 'package:bond_form/src/validation/validation_rule.dart';

/// A validation rule that checks if a string contains only alphabetic characters, digits, underscores, and hyphens.
///
/// This rule validates that the input string consists of alphabetic characters (letters),
/// digits, underscores, and hyphens only.
class AlphaDash extends ValidationRule<String?> {
  /// Creates a new instance of the [AlphaDash] validation rule.
  ///
  /// - [message]: A custom validation message (optional) to be displayed
  ///   when the validation fails.
  AlphaDash({String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.alphaDashValidationMessage(fieldName);

  @override
  bool validate(String? value, Map<String, FormFieldState> fields) {
    if (value == null) {
      return false;
    }
    return RegExp(r'^[a-zA-Z0-9_-]+$').hasMatch(value);
  }
}
