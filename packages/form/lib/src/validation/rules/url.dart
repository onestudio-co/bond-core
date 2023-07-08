import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

class Url extends ValidationRule<String> {
  Url({String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.urlValidationMessage(fieldName);

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return Uri.parse(value).isAbsolute;
  }
}
