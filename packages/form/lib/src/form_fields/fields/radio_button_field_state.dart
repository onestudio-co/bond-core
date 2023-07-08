import 'package:bond_form/src/form_fields/form_field_state.dart';

class RadioButtonFieldState<T> extends FormFieldState<T> {
  RadioButtonFieldState(
    T value, {
    required String label,
  }) : super(value: value, label: label, rules: []);
}
