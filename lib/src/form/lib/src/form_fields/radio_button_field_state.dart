import 'package:bond_form/form.dart';


class RadioButtonFieldState<T> extends FormFieldState<T> {
  RadioButtonFieldState(
    T value, {
    required String label,
    List<ValidationRule<T>> rules = const [],
  }) : super(value: value, label: label, rules: rules);
}
