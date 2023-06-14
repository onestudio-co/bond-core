import 'package:bond_core/src/form/validation/validation_rule.dart';

import 'form_field_state.dart';

class DropDownFieldState<T> extends FormFieldState<T> {
  DropDownFieldState(
    T value, {
    required String label,
    List<ValidationRule<T>> rules = const [],
  }) : super(value: value, label: label, rules: rules);
}
