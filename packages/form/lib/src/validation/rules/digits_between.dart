import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

/// A validation rule that checks if a string contains a number of digits within a specified range.
///
/// This rule validates that the input string contains a number of digits within the specified
/// minimum and maximum values (inclusive).
class DigitsBetween extends ValidationRule<String> {
  /// The minimum allowed number of digits (inclusive).
  final num min;

  /// The maximum allowed number of digits (inclusive).
  final num max;

  /// Creates a new instance of the [DigitsBetween] validation rule.
  ///
  /// - [min]: The minimum allowed number of digits (inclusive).
  /// - [max]: The maximum allowed number of digits (inclusive).
  /// - [message]: A custom validation message (optional) to be displayed
  ///   when the validation fails.
  DigitsBetween(this.min, this.max, {String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.digitsBetweenValidationMessage(fieldName, min, max);

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return RegExp('^\\d{$min,$max}\$').hasMatch(value);
  }
}
