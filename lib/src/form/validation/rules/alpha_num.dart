import 'package:bond_core_temp/src/form/validation/validation_rule.dart';
import 'package:bond_core_temp/src/form/form_fields/form_field_state.dart';

class AlphaNum extends ValidationRule<String> {
  AlphaNum({String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.alphaNumValidationMessage(fieldName);

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value);
  }
}
