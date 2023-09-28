import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

/// A validation rule that checks if a string does not exceed a maximum length.
///
/// This rule validates that the input string does not exceed the specified maximum length.
class MaxLength extends ValidationRule<String> {
  /// The maximum allowed length for the string.
  final int max;

  /// Creates a new instance of the [MaxLength] validation rule.
  ///
  /// - [max]: The maximum allowed length for the string (required).
  /// - [message]: A custom validation message (optional) to be displayed
  ///   when the validation fails.
  MaxLength(this.max, {String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.maxLengthValidationMessage(fieldName, max);

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return value.length <= max;
  }
}
