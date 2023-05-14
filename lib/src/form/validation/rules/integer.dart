import 'package:one_studio_core/src/form/validation/validation_rule.dart';
import 'package:one_studio_core/src/form/form_fields/form_field_state.dart';

class Integer extends ValidationRule<String> {
  Integer() : super('Must be an integer');

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return int.tryParse(value) != null;
  }
}
