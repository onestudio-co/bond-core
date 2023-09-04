import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

/// A validation rule that checks if a numeric value meets a minimum requirement.
///
/// This rule validates that the numeric value meets the specified minimum requirement.
class MinValue extends ValidationRule<num> {
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
  bool validate(num value, Map<String, FormFieldState> fields) {
    return value >= min;
  }
}
