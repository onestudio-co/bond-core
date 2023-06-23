import '../../../bond_form.dart';

class AlphaDash extends ValidationRule<String> {
  AlphaDash({String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.alphaDashValidationMessage(fieldName);

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return RegExp(r'^[a-zA-Z0-9_-]+$').hasMatch(value);
  }
}
