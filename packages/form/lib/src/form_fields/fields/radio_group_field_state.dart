import 'radio_button_field_state.dart';
import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

class RadioGroupFieldState<T> extends FormFieldState<T?> {
  final List<RadioButtonFieldState<T>> radioButtons;

  RadioGroupFieldState(
    this.radioButtons, {
    required String label,
    T? value,
    List<ValidationRule<T?>> rules = const [],
  }) : super(value: value, label: label, rules: rules);
}
