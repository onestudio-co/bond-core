import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

/// A validation rule that checks if a value is not in a list of invalid values.
///
/// This rule validates that the input value is not one of the invalid values specified in a list.
class NotInList<T> extends ValidationRule<T> {
  /// The list of invalid values to check against.
  final List<T> invalidValues;

  /// Creates a new instance of the [NotInList] validation rule.
  ///
  /// - [invalidValues]: The list of invalid values (required).
  /// - [message]: A custom validation message (optional) to be displayed
  ///   when the validation fails.
  NotInList(this.invalidValues, {String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.notInValuesValidationMessage(fieldName);

  @override
  bool validate(T value, Map<String, FormFieldState> fields) {
    return !invalidValues.contains(value);
  }
}
