import '../../../bond_form.dart';

class Different extends ValidationRule<String> {
  final String otherField;

  Different(this.otherField, {String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.differentValidationMessage(fieldName, otherField);

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    if (!fields.containsKey(otherField)) {
      throw ArgumentError('No field found with name $otherField');
    }

    return value != fields[otherField]?.value;
  }
}
