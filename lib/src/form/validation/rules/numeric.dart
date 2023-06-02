import 'package:bond_core/src/form/validation/validation_rule.dart';
import 'package:bond_core/src/form/form_fields/form_field_state.dart';

class Numeric extends ValidationRule<String> {
  Numeric() : super('Must be numeric');

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return double.tryParse(value) != null;
  }
}
