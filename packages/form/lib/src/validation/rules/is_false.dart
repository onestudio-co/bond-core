import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

class IsFalse extends ValidationRule<bool> {
  IsFalse({String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.isFalseValidationMessage(fieldName);

  @override
  bool validate(bool value, Map<String, FormFieldState> fields) {
    return !value;
  }
}
