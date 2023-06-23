import '../../../form.dart';

class NotInList extends ValidationRule<String> {
  final List<String> invalidValues;

  NotInList(this.invalidValues, {String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.notInValuesValidationMessage(fieldName);

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return !invalidValues.contains(value);
  }
}
