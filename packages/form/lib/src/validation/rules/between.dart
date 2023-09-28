import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

/// A validation rule that checks if the length of a string falls within a specified range.
///
/// This rule validates that the length of the input string falls within the specified
/// minimum and maximum values (inclusive).
class Between extends ValidationRule<String> {
  /// The minimum allowed length.
  final num min;

  /// The maximum allowed length.
  final num max;

  /// Creates a new instance of the [Between] validation rule.
  ///
  /// - [min]: The minimum allowed length (inclusive).
  /// - [max]: The maximum allowed length (inclusive).
  /// - [message]: A custom validation message (optional) to be displayed
  ///   when the validation fails.
  Between(this.min, this.max, {String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.betweenValidationMessage(fieldName, min, max);

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return value.length >= min && value.length <= max;
  }
}
