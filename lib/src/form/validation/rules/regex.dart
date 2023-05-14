import 'package:one_studio_core/src/form/validation/validation_rule.dart';
import 'package:one_studio_core/src/form/form_fields/form_field_state.dart';

class Regex extends ValidationRule<String> {
  final RegExp regex;

  Regex(this.regex)
      : super('Must match the pattern ${regex.pattern}');

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return regex.hasMatch(value);
  }
}
