import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

class RangeSelected<T> extends ValidationRule<Iterable<T>?> {
  final int min;
  final int max;

  RangeSelected(this.min, this.max, {String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.rangeSelectedValidationMessage(fieldName, min, max);

  @override
  bool validate(Iterable<T>? value, Map<String, FormFieldState> fields) {
    return value != null && value.length >= min && value.length <= max;
  }
}
