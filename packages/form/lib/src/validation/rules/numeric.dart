import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

/// A validation rule that checks if a string represents a valid numeric value.
///
/// This rule validates that the input string represents a valid numeric value.
class Numeric extends ValidationRule<String> {
  /// Creates a new instance of the [Numeric] validation rule.
  ///
  /// - [message]: A custom validation message (optional) to be displayed
  ///   when the validation fails.
  Numeric({String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.numericValidationMessage(fieldName);

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return double.tryParse(value) != null;
  }
}
