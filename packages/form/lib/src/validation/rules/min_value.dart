import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

class MinValue extends ValidationRule<num> {
  MinValue(this.min, {String? message}) : super(message);

  final int min;

  @override
  String validatorMessage(String fieldName) =>
      l10n.minValueValidationMessage(fieldName, min);

  @override
  bool validate(num value, Map<String, FormFieldState> fields) {
    return value >= min;
  }
}
