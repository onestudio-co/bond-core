import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

/// A validation rule that checks if a string represents a boolean value.
///
/// This rule validates that the input string represents a boolean value, such as
/// "true", "false", "1", or "0".
class Boolean extends ValidationRule<String> {
  /// Creates a new instance of the [Boolean] validation rule.
  ///
  /// - [message]: A custom validation message (optional) to be displayed
  ///   when the validation fails.
  Boolean({String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.booleanValidationMessage(fieldName);

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return ['true', 'false', '1', '0'].contains(value.toLowerCase());
  }
}
