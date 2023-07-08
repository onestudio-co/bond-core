import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

class Alpha extends ValidationRule<String> {
  Alpha({String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.alphaValidationMessage(fieldName);

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return RegExp(r'^[a-zA-Z]+$').hasMatch(value);
  }
}
