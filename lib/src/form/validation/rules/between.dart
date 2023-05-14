import 'package:one_studio_core/src/form/validation/validation_rule.dart';
import 'package:one_studio_core/src/form/form_fields/form_field_state.dart';

class Between extends ValidationRule<String> {
  final int min;
  final int max;

  Between(this.min, this.max)
      : super('Must be between $min and $max characters');

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return value.length >= min && value.length <= max;
  }
}
