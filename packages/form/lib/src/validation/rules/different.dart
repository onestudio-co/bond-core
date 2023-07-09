import 'package:bond_form/src/form_fields/form_field_state.dart';
import 'package:bond_form/src/validation/validation_rule.dart';

class Different<T> extends ValidationRule<T> {
  final String otherField;

  Different(this.otherField, {String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.differentValidationMessage(fieldName, otherField);

  @override
  bool validate(T value, Map<String, FormFieldState> fields) {
    if (!fields.containsKey(otherField)) {
      throw ArgumentError('No field found with name $otherField');
    }

    return value != fields[otherField]?.value;
  }
}

Different<T> different<T>(
  String otherField, {
  String? message,
}) =>
    Different<T>(otherField, message: message);
