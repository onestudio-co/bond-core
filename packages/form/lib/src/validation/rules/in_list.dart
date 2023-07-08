import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

class InList<T> extends ValidationRule<T> {
  final List<T> validValues;

  InList(this.validValues, {String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.inValuesValidationMessage(fieldName);

  @override
  bool validate(T value, Map<String, FormFieldState> fields) {
    return validValues.contains(value);
  }
}
