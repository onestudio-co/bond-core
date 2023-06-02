import 'package:bond_core/src/form/validation/validation_rule.dart';
import 'package:bond_core/src/form/form_fields/form_field_state.dart';

class InList extends ValidationRule<String> {
  final List<String> validValues;

  InList(this.validValues)
      : super('Must be one of: ${validValues.join(', ')}');

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return validValues.contains(value);
  }
}
