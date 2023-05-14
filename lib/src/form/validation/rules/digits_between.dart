import 'package:one_studio_core/src/form/validation/validation_rule.dart';
import 'package:one_studio_core/src/form/form_fields/form_field_state.dart';

class DigitsBetween extends ValidationRule<String> {
  final int min;
  final int max;
  DigitsBetween(this.min, this.max) : super('Must be numeric with between $min and $max digits');

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return RegExp('^\\d{$min,$max}\$').hasMatch(value);
  }
}
