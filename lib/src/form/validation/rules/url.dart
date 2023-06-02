import 'package:bond_core/src/form/validation/validation_rule.dart';
import 'package:bond_core/src/form/form_fields/form_field_state.dart';

class Url extends ValidationRule<String> {
  Url() : super('Must be a valid URL');

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return Uri.parse(value).isAbsolute;
  }
}
