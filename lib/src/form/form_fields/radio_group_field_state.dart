import 'package:bond_core_temp/src/form/validation/validation_rule.dart';

import 'form_field_state.dart';
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
