import '../../../bond_form.dart';

class Required extends ValidationRule<String> {
  Required({String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.requiredValidationMessage(fieldName);

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return value.isNotEmpty;
  }
}
