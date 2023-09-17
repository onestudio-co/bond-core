import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

/// A validation rule that checks if the number of selected items in an iterable
/// does not exceed a maximum limit.
///
/// This rule validates that the number of selected items in the input iterable
/// does not exceed the specified maximum limit.
class MaxSelected<T extends Iterable<G>, G> extends ValidationRule<T> {
  /// The maximum allowed number of selected items.
  final int max;

  /// Creates a new instance of the [MaxSelected] validation rule.
  ///
  /// - [max]: The maximum allowed number of selected items (required).
  /// - [message]: A custom validation message (optional) to be displayed
  ///   when the validation fails.
  MaxSelected(this.max, {String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.maxSelectedValidationMessage(fieldName, max);

  @override
  bool validate(T? value, Map<String, FormFieldState> fields) {
    return value != null && value.length <= max;
  }
}
