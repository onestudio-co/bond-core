import 'package:one_studio_core/src/form/validation/validation_rule.dart';
import 'package:one_studio_core/src/form/form_fields/form_field_state.dart';

class Boolean extends ValidationRule<String> {
  Boolean() : super('Must be a boolean value');

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return ['true', 'false', '1', '0'].contains(value.toLowerCase());
  }
}
