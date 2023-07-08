import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

class MaxValue extends ValidationRule<num> {
  MaxValue(this.max, {String? message}) : super(message);

  final int max;

  @override
  String validatorMessage(String fieldName) =>
      l10n.maxValueValidationMessage(fieldName, max);

  @override
  bool validate(num value, Map<String, FormFieldState> fields) {
    return value <= max;
  }
}
