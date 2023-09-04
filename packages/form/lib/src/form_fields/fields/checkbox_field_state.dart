import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

/// Represents the state of a checkbox form field.
///
/// A checkbox form field extends the [FormFieldState] class, adding support for
/// handling the state of a checkbox input.
class CheckboxFieldState<T> extends FormFieldState<T?> {
  /// Creates a new instance of [CheckboxFieldState].
  ///
  /// - [value]: The initial value of the checkbox (checked or unchecked).
  /// - [label]: The label or name of the checkbox form field (required).
  /// - [rules]: The list of validation rules to apply to the checkbox field (default is an empty list).
  CheckboxFieldState(
      T? value, {
        required String label,
        List<ValidationRule<T?>> rules = const [],
      }) : super(value: value, label: label, rules: rules);
}
