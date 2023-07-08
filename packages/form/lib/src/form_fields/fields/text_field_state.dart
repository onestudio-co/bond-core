import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

class TextFieldState extends FormFieldState<String?> {
  TextFieldState(
    String? value, {
    required String label,
    List<ValidationRule<String?>> rules = const [],
    bool validateOnUpdate = true,
    bool touched = false,
  }) : super(
          value: value,
          label: label,
          rules: rules,
          validateOnUpdate: validateOnUpdate,
          touched: touched,
        );
}
