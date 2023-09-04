import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

/// A validation rule that checks if a value is in a list of valid values.
///
/// This rule validates that the input value is one of the valid values specified in a list.
class InList<T> extends ValidationRule<T> {
  /// The list of valid values to check against.
  final List<T> validValues;

  /// Creates a new instance of the [InList] validation rule.
  ///
  /// - [validValues]: The list of valid values (required).
  /// - [message]: A custom validation message (optional) to be displayed
  ///   when the validation fails.
  InList(this.validValues, {String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.inValuesValidationMessage(fieldName);

  @override
  bool validate(T value, Map<String, FormFieldState> fields) {
    return validValues.contains(value);
  }
}
