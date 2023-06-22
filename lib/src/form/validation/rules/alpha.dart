import 'package:bond_core_temp/src/form/form_fields/form_field_state.dart';
import 'package:bond_core_temp/src/form/validation/validation_rule.dart';

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
