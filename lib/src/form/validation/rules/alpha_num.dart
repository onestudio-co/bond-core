import 'package:bond_core/src/form/validation/validation_rule.dart';
import 'package:bond_core/src/form/form_fields/form_field_state.dart';

class AlphaNum extends ValidationRule<String> {
  AlphaNum() : super('Must be entirely alpha-numeric characters');

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value);
  }
}
