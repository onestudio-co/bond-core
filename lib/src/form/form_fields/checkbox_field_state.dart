import 'package:bond_core/src/form/validation/validation_rule.dart';

import 'form_field_state.dart';

class CheckboxFieldState extends FormFieldState<bool?> {
  CheckboxFieldState(
    bool? value, {
    required String label,
    List<ValidationRule<bool?>> rules = const [],
  }) : super(value: value, label: label, rules: rules);

  @override
  void update(bool? newValue) {
    value = newValue;
  }
}
