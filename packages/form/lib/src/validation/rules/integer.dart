import '../../../form.dart';

class Integer extends ValidationRule<String> {
  Integer({String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.integerValidationMessage(fieldName);

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return int.tryParse(value) != null;
  }
}
