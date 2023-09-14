import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

/// A validation rule that checks if the number of selected items in an iterable
/// meets a minimum requirement.
///
/// This rule validates that the number of selected items in the input iterable
/// meets the specified minimum requirement.
class MinSelected<T extends Iterable<G>, G> extends ValidationRule<T?> {
  /// The minimum required number of selected items.
  final int min;

  /// Creates a new instance of the [MinSelected] validation rule.
  ///
  /// - [min]: The minimum required number of selected items (required).
  /// - [message]: A custom validation message (optional) to be displayed
  ///   when the validation fails.
  MinSelected(this.min, {String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.minSelectedValidationMessage(fieldName, min);

  @override
  bool validate(T? value, Map<String, FormFieldState> fields) {
    return value != null && value.length >= min;
  }
}
