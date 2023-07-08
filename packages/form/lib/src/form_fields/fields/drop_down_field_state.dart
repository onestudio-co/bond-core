import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

class DropDownFieldState<T> extends FormFieldState<T> {
  DropDownFieldState(
    T value, {
    required String label,
    List<ValidationRule<T>> rules = const [],
  }) : super(value: value, label: label, rules: rules);
}
