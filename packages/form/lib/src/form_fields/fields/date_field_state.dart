import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

class DateFieldState extends FormFieldState<DateTime?> {
  DateFieldState(
    DateTime? value, {
    required String label,
    List<ValidationRule<DateTime?>> rules = const [],
  }) : super(value: value, label: label, rules: rules);
}
