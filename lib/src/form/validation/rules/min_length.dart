import 'package:one_studio_core/src/form/validation/validation_rule.dart';
import 'package:one_studio_core/src/form/form_fields/form_field_state.dart';

class MinLength extends ValidationRule<String> {
  final int min;

  MinLength(this.min) : super('Must be at least $min characters');

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return value.length >= min;
  }
}
