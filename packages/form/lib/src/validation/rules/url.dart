import '../../../bond_form.dart';

class Url extends ValidationRule<String> {
  Url({String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.urlValidationMessage(fieldName);

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return Uri.parse(value).isAbsolute;
  }
}
