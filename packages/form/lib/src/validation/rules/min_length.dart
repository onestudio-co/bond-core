import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

/// A validation rule that checks if a string meets a minimum length requirement.
///
/// This rule validates that the input string meets the specified minimum length requirement.
class MinLength extends ValidationRule<String> {
  /// The minimum required length for the string.
  final int min;

  /// Creates a new instance of the [MinLength] validation rule.
  ///
  /// - [min]: The minimum required length for the string (required).
  /// - [message]: A custom validation message (optional) to be displayed
  ///   when the validation fails.
  MinLength(this.min, {String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.minLengthValidationMessage(fieldName, min);

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return value.length >= min;
  }
}
