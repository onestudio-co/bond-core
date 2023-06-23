import '../../../bond_form.dart';

class Digits extends ValidationRule<String> {
  final int digitLength;

  Digits(this.digitLength, {String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.digitsValidationMessage(fieldName, digitLength);

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return RegExp('^\\d{$digitLength}\$').hasMatch(value);
  }
}
