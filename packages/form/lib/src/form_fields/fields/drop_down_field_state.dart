import 'package:bond_form/src/form_fields.dart';
import 'package:bond_form/src/validation/rules.dart';

/// Represents the state of a dropdown (select) form field.
///
/// A dropdown form field extends the [FormFieldState] class, providing
/// a way to manage the state of a dropdown input.
class DropDownFieldState<T> extends FormFieldState<T> {
  /// The list of individual item states within the dropdown.
  final List<DropDownItemState<T>> items;

  /// Creates a new instance of [DropDownFieldState].
  ///
  /// - [value]: The initial value of the dropdown field (selected item).
  /// - [items]: The list of individual item states within the dropdown (required).
  /// - [label]: The label or name of the dropdown form field (required).
  /// - [rules]: The list of validation rules to apply to the dropdown field (default is an empty list).
  DropDownFieldState(
      T value, {
        required this.items,
        required String label,
        List<ValidationRule<T>> rules = const [],
      }) : super(value: value, label: label, rules: rules);
}