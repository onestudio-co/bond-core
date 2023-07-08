import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

class NotInList<T> extends ValidationRule<T> {
  final List<T> invalidValues;

  NotInList(this.invalidValues, {String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.notInValuesValidationMessage(fieldName);

  @override
  bool validate(T value, Map<String, FormFieldState> fields) {
    return !invalidValues.contains(value);
  }
}
