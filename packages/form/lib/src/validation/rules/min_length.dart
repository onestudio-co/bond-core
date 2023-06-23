import '../../../bond_form.dart';

class MinLength extends ValidationRule<String> {
  final int min;

  MinLength(this.min, {String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.minLengthValidationMessage(fieldName, min);

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return value.length >= min;
  }
}
