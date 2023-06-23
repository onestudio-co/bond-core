import '../../form.dart';

import 'radio_button_field_state.dart';

class RadioGroupFieldState<T> extends FormFieldState<T> {
  final List<RadioButtonFieldState<T>> radioButtons;

  RadioGroupFieldState(
    this.radioButtons, {
    required String label,
    T? value,
    List<ValidationRule<T>> rules = const [],
  }) : super(
            value: value ?? radioButtons.first.value,
            label: label,
            rules: rules);
}
