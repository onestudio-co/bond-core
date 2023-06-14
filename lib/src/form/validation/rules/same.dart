import 'package:bond_core/src/form/validation/validation_rule.dart';
import 'package:bond_core/src/form/form_fields/form_field_state.dart';

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
