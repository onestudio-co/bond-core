import '../../form.dart';

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
