import '../../../form.dart';

class Numeric extends ValidationRule<String> {
  Numeric({String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.numericValidationMessage(fieldName);

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return double.tryParse(value) != null;
  }
}
