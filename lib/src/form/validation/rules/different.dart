import 'package:bond_core/src/form/validation/validation_rule.dart';
import 'package:bond_core/src/form/form_fields/form_field_state.dart';

class Different extends ValidationRule<String> {
  final String otherField;

  Different(this.otherField) : super('Must be different from the other field');

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    if (!fields.containsKey(otherField)) {
      throw ArgumentError('No field found with name $otherField');
    }

    return value != fields[otherField]?.value;
  }
}
