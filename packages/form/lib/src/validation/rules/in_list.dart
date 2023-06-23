import '../../../form.dart';

class InList extends ValidationRule<String> {
  final List<String> validValues;

  InList(this.validValues, {String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.inValuesValidationMessage(fieldName);

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return validValues.contains(value);
  }
}
