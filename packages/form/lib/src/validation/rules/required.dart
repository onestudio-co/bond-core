import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

class Required<T> extends ValidationRule<T?> {
  Required({String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.requiredValidationMessage(fieldName);

  @override
  bool validate(T? value, Map<String, FormFieldState> fields) {
    if (value is String) {
      return value.isNotEmpty;
    }
    if (value is List) {
      return value.isNotEmpty;
    }
    return value != null;
  }
}
