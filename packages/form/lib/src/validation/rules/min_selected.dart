import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

class MinSelected<T> extends ValidationRule<Iterable<T>?> {
  final int min;

  MinSelected(this.min, {String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.minSelectedValidationMessage(fieldName, min);

  @override
  bool validate(Iterable<T>? value, Map<String, FormFieldState> fields) {
    return value != null && value.length >= min;
  }
}
