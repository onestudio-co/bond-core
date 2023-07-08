import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

class Boolean extends ValidationRule<String> {
  Boolean({String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.booleanValidationMessage(fieldName);

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return ['true', 'false', '1', '0'].contains(value.toLowerCase());
  }
}
