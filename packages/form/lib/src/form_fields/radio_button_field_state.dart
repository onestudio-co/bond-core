import '../../bond_form.dart';

class RadioButtonFieldState<T> extends FormFieldState<T> {
  RadioButtonFieldState(
    T value, {
    required String label,
  }) : super(value: value, label: label, rules: []);
}
