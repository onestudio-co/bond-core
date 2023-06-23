import '../../../bond_form.dart';

class MaxLength extends ValidationRule<String> {
  final int max;

  MaxLength(this.max, {String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.maxLengthValidationMessage(fieldName, max);

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return value.length <= max;
  }
}
