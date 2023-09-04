import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

import 'checkbox_field_state.dart';

/// Represents the state of a group of checkbox form fields.
///
/// A checkbox group form field extends the [FormFieldState] class, providing
/// a way to manage the state of multiple checkboxes within a group.
class CheckboxGroupFieldState<T> extends FormFieldState<Set<T>?> {
  /// The list of individual checkbox field states within the group.
  final List<CheckboxFieldState<T>> checkboxes;

  /// Creates a new instance of [CheckboxGroupFieldState].
  ///
  /// - [checkboxes]: The list of individual checkbox field states within the group (required).
  /// - [label]: The label or name of the checkbox group form field (required).
  /// - [value]: The initial value of the checkbox group (default is `null`).
  /// - [rules]: The list of validation rules to apply to the checkbox group field (default is an empty list).
  CheckboxGroupFieldState(
      this.checkboxes, {
        required String label,
        Set<T>? value,
        List<ValidationRule<Set<T>?>> rules = const [],
      }) : super(value: value, label: label, rules: rules);
}
