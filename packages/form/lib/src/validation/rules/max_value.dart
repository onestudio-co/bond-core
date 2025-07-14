import 'package:bond_form/src/form_fields/form_field_state.dart';
import 'package:bond_form/src/validation/validation_rule.dart';

/// A validation rule that checks if a numeric value does not exceed a maximum limit.
///
/// This rule validates that the numeric value does not exceed the specified maximum limit.
class MaxValue extends ValidationRule<String> {
  /// The maximum allowed numeric value.
  final int max;

  /// Creates a new instance of the [MaxValue] validation rule.
  ///
  /// - [max]: The maximum allowed numeric value (required).
  /// - [message]: A custom validation message (optional) to be displayed
  ///   when the validation fails.
  MaxValue(this.max, {String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.maxValueValidationMessage(fieldName, max);

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    // Attempt to parse the value as an integer.
    final parsedValue = num.tryParse(value);
    // If parsing fails, the value is invalid.
    if (parsedValue == null) {
      return false;
    }
    return parsedValue <= max;
  }
}
