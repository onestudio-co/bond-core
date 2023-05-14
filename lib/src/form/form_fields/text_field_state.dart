import 'package:one_studio_core/src/form/validation/validation_rule.dart';

import 'form_field_state.dart';

class TextFieldState extends FormFieldState<String?> {
  TextFieldState(
    String? value, {
    required String label,
    List<ValidationRule<String?>> rules = const [],
  }) : super(value: value, label: label, rules: rules);

  @override
  void update(String? newValue) {
    value = newValue;
  }
}
