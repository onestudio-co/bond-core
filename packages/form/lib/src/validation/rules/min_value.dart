import 'package:bond_form/src/form_fields/form_field_state.dart';
import 'package:bond_form/src/validation/validation_rule.dart';

/// A validation rule that checks if a numeric value meets a minimum requirement.
///
/// This rule validates that the numeric value meets the specified minimum requirement.
class MinValue extends ValidationRule<String> {
  /// The minimum required numeric value.
  final int min;

  /// Creates a new instance of the [MinValue] validation rule.
  ///
  /// - [min]: The minimum required numeric value (required).
  /// - [message]: A custom validation message (optional) to be displayed
  ///   when the validation fails.
  MinValue(this.min, {String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.minValueValidationMessage(fieldName, min);

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    // Attempt to parse the value as an integer.
    final parsedValue = num.tryParse(value);
    // If parsing fails, the value is invalid.
    if (parsedValue == null) {
      return false;
    }
    return parsedValue >= min;
  }
}
