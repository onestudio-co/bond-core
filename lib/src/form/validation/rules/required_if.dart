import 'package:one_studio_core/src/form/form_fields/form_field_state.dart';
import 'package:one_studio_core/src/form/validation/validation_rule.dart';

class RequiredIf extends ValidationRule<String> {
  final String? otherFieldName;
  final dynamic expectedValue;
  final bool Function()? condition;

  RequiredIf(this.otherFieldName, {required this.expectedValue})
      : condition = null,
        super("This field is required");

  RequiredIf.condition(this.condition)
      : otherFieldName = null,
        expectedValue = null,
        super("This field is required");

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
