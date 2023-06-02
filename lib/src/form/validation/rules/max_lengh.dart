import 'package:bond_core/src/form/validation/validation_rule.dart';
import 'package:bond_core/src/form/form_fields/form_field_state.dart';

class MaxLength extends ValidationRule<String> {
  final int max;

  MaxLength(this.max) : super('Must be at most $max characters');

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return value.length <= max;
  }
}
