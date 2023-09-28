import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

/// A validation rule that checks if the number of selected items in an iterable
/// falls within a specified range.
///
/// This rule validates that the number of selected items in the input iterable
/// falls within the specified minimum and maximum range.
class RangeSelected<T> extends ValidationRule<Iterable<T>?> {
  /// The minimum required number of selected items.
  final int min;

  /// The maximum allowed number of selected items.
  final int max;

  /// Creates a new instance of the [RangeSelected] validation rule.
  ///
  /// - [min]: The minimum required number of selected items (required).
  /// - [max]: The maximum allowed number of selected items (required).
  /// - [message]: A custom validation message (optional) to be displayed
  ///   when the validation fails.
  RangeSelected(this.min, this.max, {String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.rangeSelectedValidationMessage(fieldName, min, max);

  @override
  bool validate(Iterable<T>? value, Map<String, FormFieldState> fields) {
    return value != null && value.length >= min && value.length <= max;
  }
}
