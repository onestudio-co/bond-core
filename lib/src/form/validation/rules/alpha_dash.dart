import 'package:bond_core/src/form/validation/validation_rule.dart';
import 'package:bond_core/src/form/form_fields/form_field_state.dart';

class AlphaDash extends ValidationRule<String> {
  AlphaDash()
      : super('Must be alpha-numeric, dash, or underscore');

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return RegExp(r'^[a-zA-Z0-9_-]+$').hasMatch(value);
  }
}
