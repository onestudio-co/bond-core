import 'package:bond_core/src/form/form_fields/form_field_state.dart';
import 'package:bond_core/src/form/validation/validation_rule.dart';

class Alpha extends ValidationRule<String> {
  Alpha() : super('Must be entirely alphabetic characters');

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return RegExp(r'^[a-zA-Z]+$').hasMatch(value);
  }
}
