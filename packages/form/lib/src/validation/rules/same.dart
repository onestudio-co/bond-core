import '../../../bond_form.dart';

class Same extends ValidationRule<String> {
  final String otherField;

  Same(this.otherField, {String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.sameValidationMessage(fieldName, otherField);

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    if (!fields.containsKey(otherField)) {
      throw ArgumentError('Field $otherField does not exist');
    }
    return value == fields[otherField]!.value;
  }
}
