import '../../../form.dart';

class DigitsBetween extends ValidationRule<String> {
  final int min;
  final int max;

  DigitsBetween(this.min, this.max, {String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.digitsBetweenValidationMessage(fieldName, min, max);

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return RegExp('^\\d{$min,$max}\$').hasMatch(value);
  }
}
