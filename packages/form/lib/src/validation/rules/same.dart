import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

class Same<T> extends ValidationRule<T> {
  final String otherField;

  Same(this.otherField, {String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.sameValidationMessage(fieldName, otherField);

  @override
  bool validate(T value, Map<String, FormFieldState> fields) {
    if (!fields.containsKey(otherField)) {
      throw ArgumentError('Field $otherField does not exist');
    }
    return value == fields[otherField]!.value;
  }
}
