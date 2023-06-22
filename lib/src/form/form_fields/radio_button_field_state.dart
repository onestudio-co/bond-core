import 'package:bond_core_temp/src/form/validation/validation_rule.dart';

import 'form_field_state.dart';

class RadioButtonFieldState<T> extends FormFieldState<T> {
  RadioButtonFieldState(
    T value, {
    required String label,
    List<ValidationRule<T>> rules = const [],
  }) : super(value: value, label: label, rules: rules);
}
