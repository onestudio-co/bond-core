import 'package:bond_form/form.dart';

class CheckboxFieldState extends FormFieldState<bool?> {
  CheckboxFieldState(
    bool? value, {
    required String label,
    List<ValidationRule<bool?>> rules = const [],
  }) : super(value: value, label: label, rules: rules);
}
