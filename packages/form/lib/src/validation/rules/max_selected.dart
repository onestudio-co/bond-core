import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

class MaxSelected<T> extends ValidationRule<Iterable<T>?> {
  final int max;

  MaxSelected(this.max, {String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.maxSelectedValidationMessage(fieldName, max);

  @override
  bool validate(Iterable<T>? value, Map<String, FormFieldState> fields) {
    return value != null && value.length <= max;
  }
}
