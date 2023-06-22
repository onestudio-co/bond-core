import 'package:bond_core_temp/src/form/validation/validation_rule.dart';
import 'package:bond_core_temp/src/form/form_fields/form_field_state.dart';

class Date extends ValidationRule<String> {
  Date({String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.dateValidationMessage(fieldName);

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    try {
      DateTime.parse(value);
      return true;
    } catch (e) {
      return false;
    }
  }
}
