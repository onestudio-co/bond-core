import 'package:bond_core/src/form/validation/validation_rule.dart';
import 'package:bond_core/src/form/form_fields/form_field_state.dart';

class Email extends ValidationRule<String> {
  Email() : super('Invalid email address');

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return RegExp(r'^.+@[a-zA-Z]+\.[a-zA-Z]+(\.?[a-zA-Z]+)$').hasMatch(value);
  }
}
