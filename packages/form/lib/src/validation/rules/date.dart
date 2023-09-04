import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

/// A validation rule that checks if a string represents a valid date.
///
/// This rule validates that the input string represents a valid date when parsed.
class Date extends ValidationRule<String> {
  /// Creates a new instance of the [Date] validation rule.
  ///
  /// - [message]: A custom validation message (optional) to be displayed
  ///   when the validation fails.
  Date({String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.dateValidationMessage(fieldName);

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    try {
      DateTime.parse(value);
      return true;
    } catch (e) {
      return false;
    }
  }
}
