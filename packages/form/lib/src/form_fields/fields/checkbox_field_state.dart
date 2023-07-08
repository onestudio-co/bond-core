import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

class CheckboxFieldState<T> extends FormFieldState<T?> {
  CheckboxFieldState(
    T? value, {
    required String label,
    List<ValidationRule<T?>> rules = const [],
  }) : super(value: value, label: label, rules: rules);
}
