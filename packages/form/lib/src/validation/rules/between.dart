import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

class Between extends ValidationRule<String> {
  final num min;
  final num max;

  Between(this.min, this.max, {String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.betweenValidationMessage(fieldName, min, max);

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return value.length >= min && value.length <= max;
  }
}
