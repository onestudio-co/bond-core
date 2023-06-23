import 'package:bond_form/form.dart';

class DropDownFieldState<T> extends FormFieldState<T> {
  DropDownFieldState(
    T value, {
    required String label,
    List<ValidationRule<T>> rules = const [],
  }) : super(value: value, label: label, rules: rules);
}
