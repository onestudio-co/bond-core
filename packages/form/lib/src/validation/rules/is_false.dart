import 'package:bond_form/src/form_fields/form_field_state.dart';
import 'package:bond_form/src/validation/validation_rule.dart';

/// A validation rule that checks if a boolean value is false.
///
/// This rule validates that the input boolean value is false.
class IsFalse extends ValidationRule<bool?> {
  /// Creates a new instance of the [IsFalse] validation rule.
  ///
  /// - [message] A custom validation message (optional) to be displayed
  ///   when the validation fails.
  IsFalse({String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.isFalseValidationMessage(fieldName);

  @override
  bool validate(bool? value, Map<String, FormFieldState> fields) {
    return value == false;
  }
}
