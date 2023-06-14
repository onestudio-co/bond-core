import 'package:bond_core/src/form/validation/validation_rule.dart';
import 'package:bond_core/src/form/form_fields/form_field_state.dart';

class Email extends ValidationRule<String> {
  Email({String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.emailValidationMessage(fieldName);

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return RegExp(r'^.+@[a-zA-Z]+\.[a-zA-Z]+(\.?[a-zA-Z]+)$').hasMatch(value);
  }
}
