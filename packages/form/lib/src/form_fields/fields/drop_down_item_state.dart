import 'package:bond_form/src/form_fields/form_field_state.dart';

class DropDownItemState<T> extends FormFieldState<T> {
  DropDownItemState(
    T value, {
    required String label,
  }) : super(value: value, label: label, rules: const []);
}
