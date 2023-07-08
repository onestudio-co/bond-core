import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

import 'checkbox_field_state.dart';

class CheckboxGroupFieldState<T> extends FormFieldState<Set<T>?> {
  final List<CheckboxFieldState<T>> checkboxes;

  CheckboxGroupFieldState(
    this.checkboxes, {
    required String label,
    Set<T>? value,
    List<ValidationRule<Set<T>?>> rules = const [],
  }) : super(value: value, label: label, rules: rules);
}
