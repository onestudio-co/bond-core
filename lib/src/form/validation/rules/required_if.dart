import 'package:bond_core_temp/src/form/form_fields/form_field_state.dart';
import 'package:bond_core_temp/src/form/validation/validation_rule.dart';

class RequiredIf extends ValidationRule<String> {
  final String? otherFieldName;
  final dynamic expectedValue;
  final bool Function()? condition;

  RequiredIf(this.otherFieldName,
      {required this.expectedValue, String? message})
      : condition = null,
        super(message);

  RequiredIf.condition(this.condition, {String? message})
      : otherFieldName = null,
        expectedValue = null,
        super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.requiredValidationMessage(fieldName);

  @override
  bool validate(String? value, Map<String, FormFieldState> fields) {
    if (condition != null) {
      if (condition!()) {
        return value != null && value.isNotEmpty;
      }
    } else if (fields[otherFieldName!]?.value == expectedValue) {
      return value != null && value.isNotEmpty;
    }
    return true;
  }
}
