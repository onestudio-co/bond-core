import 'package:bond_core_temp/src/form/validation/validation_rule.dart';

import 'form_field_state.dart';

class DateFieldState extends FormFieldState<DateTime?> {
  DateFieldState(
      DateTime? value, {
        required String label,
        List<ValidationRule<DateTime?>> rules = const [],
      }) : super(value: value, label: label, rules: rules);
}
