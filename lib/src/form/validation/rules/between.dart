import 'package:bond_core/src/form/validation/validation_rule.dart';
import 'package:bond_core/src/form/form_fields/form_field_state.dart';

class Between extends ValidationRule<String> {
  final int min;
  final int max;

  Between(this.min, this.max, {String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.betweenValidationMessage(fieldName, min, max);

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return value.length >= min && value.length <= max;
  }
}
