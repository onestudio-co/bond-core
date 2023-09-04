import 'package:bond_form/src/form_fields/form_field_state.dart';

/// Represents the state of an individual item within a dropdown (select) field.
///
/// A `DropDownItemState` extends the [FormFieldState] class, providing
/// a way to manage the state of an item within a dropdown input.
class DropDownItemState<T> extends FormFieldState<T> {
  /// Creates a new instance of [DropDownItemState].
  ///
  /// - [value]: The value associated with the dropdown item (required).
  /// - [label]: The label or name of the dropdown item (required).
  DropDownItemState(
      T value, {
        required String label,
      }) : super(value: value, label: label, rules: const []);
}