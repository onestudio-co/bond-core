import 'package:one_studio_core/src/form/validation/validation_rule.dart';
import 'package:one_studio_core/src/form/form_fields/form_field_state.dart';

class Date extends ValidationRule<String> {
  Date() : super('Must be a valid date');

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    try {
      DateTime.parse(value);
      return true;
    } catch (e) {
      return false;
    }
  }
}
