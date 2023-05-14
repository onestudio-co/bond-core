import 'package:one_studio_core/src/form/validation/validation_rule.dart';
import 'package:one_studio_core/src/form/form_fields/form_field_state.dart';

class Same extends ValidationRule<String> {
  final String otherFieldValue;

  Same(this.otherFieldValue)
      : super('Must be the same as the other field');

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return value == otherFieldValue;
  }
}
