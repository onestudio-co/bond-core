import 'package:one_studio_core/src/form/validation/validation_rule.dart';
import 'package:one_studio_core/src/form/form_fields/form_field_state.dart';

class Required extends ValidationRule<String> {
  Required() : super('Field is required');

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return value.isNotEmpty;
  }
}
