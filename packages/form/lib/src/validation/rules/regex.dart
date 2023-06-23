import '../../../bond_form.dart';

class Regex extends ValidationRule<String> {
  final RegExp regex;

  Regex(this.regex, {String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.regexValidationMessage(fieldName);

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return regex.hasMatch(value);
  }
}
