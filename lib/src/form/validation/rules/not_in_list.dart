import 'package:bond_core/src/form/validation/validation_rule.dart';
import 'package:bond_core/src/form/form_fields/form_field_state.dart';



class NotInList extends ValidationRule<String> {
  final List<String> invalidValues;

  NotInList(this.invalidValues)
      : super('Must not be one of: ${invalidValues.join(', ')}');

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return !invalidValues.contains(value);
  }
}
