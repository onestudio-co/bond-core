import 'package:bond_core/src/form/validation/validation_rule.dart';
import 'package:bond_core/src/form/form_fields/form_field_state.dart';

class Nullable extends ValidationRule<String?> {
  Nullable() : super('Field can be null');

  @override
  bool validate(String? value, Map<String, FormFieldState> fields) {
    return true; // All values, including null, are valid
  }
}
