import 'package:bond_form/src/form_fields/form_field_state.dart';
import 'package:bond_form/src/validation/validation_rule.dart';

/// A validation rule that checks if the value of a num falls within a specified range.
///
/// This rule validates that the value of the num falls within the specified
/// minimum and maximum values (inclusive).
class BetweenValue extends ValidationRule<String> {
  /// The minimum allowed length.
  final num min;

  /// The maximum allowed length.
  final num max;

  /// Creates a new instance of the [BetweenValue] validation rule.
  ///
  /// - [min]: The minimum allowed length (inclusive).
  /// - [max]: The maximum allowed length (inclusive).
  /// - [message]: A custom validation message (optional) to be displayed
  ///   when the validation fails.
  BetweenValue(this.min, this.max, {String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.betweenValidationMessage(fieldName, min, max);

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    // Attempt to parse the value as a double.
    final parsedValue = num.tryParse(value);
    // If parsing fails, the value is invalid.
    if (parsedValue == null) {
      return false;
    }
    return parsedValue >= min && parsedValue <= max;
  }
}
