import 'package:bond_form/src/form_fields/form_field_state.dart';
import 'package:bond_form/src/validation/validation_rule.dart';

class RequiredIf<T> extends ValidationRule<T> {
  final String? otherFieldName;
  final dynamic equalTo;
  final bool Function()? condition;

  RequiredIf(this.otherFieldName, {required this.equalTo, String? message})
      : condition = null,
        super(message);

  RequiredIf.condition(this.condition, {String? message})
      : otherFieldName = null,
        equalTo = null,
        super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.requiredValidationMessage(fieldName);

  @override
  bool validate(T value, Map<String, FormFieldState> fields) {
    var requiredConditionFulfilled = false;

    if (condition != null) {
      requiredConditionFulfilled = condition!();
    } else if (fields[otherFieldName!]?.value == equalTo) {
      requiredConditionFulfilled = true;
    }
    if (requiredConditionFulfilled) {
      if (value is String) {
        return value.isNotEmpty;
      } else if (value is List) {
        return value.isNotEmpty;
      } else {
        return value != null;
      }
    }
    return true;
  }
}
