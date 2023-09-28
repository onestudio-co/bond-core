import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

/// A validation rule that checks if a boolean value is true.
///
/// This rule validates that the input boolean value is true.
class IsTrue extends ValidationRule<bool> {
  /// Creates a new instance of the [IsTrue] validation rule.
  ///
  /// - [message]: A custom validation message (optional) to be displayed
  ///   when the validation fails.
  IsTrue({String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.isTrueValidationMessage(fieldName);

  @override
  bool validate(bool value, Map<String, FormFieldState> fields) {
    return value;
  }
}
