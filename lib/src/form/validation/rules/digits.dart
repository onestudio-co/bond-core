import 'package:one_studio_core/src/form/validation/validation_rule.dart';
import 'package:one_studio_core/src/form/form_fields/form_field_state.dart';

class Digits extends ValidationRule<String> {
  final int digitLength;
  Digits(this.digitLength) : super('Must be numeric with exactly $digitLength digits');

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return RegExp('^\\d{$digitLength}\$').hasMatch(value);
  }
}
