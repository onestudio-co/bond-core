import 'package:bond_form/bond_form.dart';

/// Represents the state of a group of radio buttons form fields.
///
/// A radio button group form field extends the [FormFieldState] class, providing
/// a way to manage the state of multiple radio buttons within a group.
class RadioGroupFieldState<T> extends FormFieldState<T?> {
  /// The list of individual radio button field states within the group.
  final List<RadioButtonFieldState<T>> radioButtons;

  /// Creates a new instance of [RadioGroupFieldState].
  ///
  /// - [radioButtons]: The list of individual radio button field states within the group (required).
  /// - [label]: The label or name of the radio button group form field (required).
  /// - [value]: The initial value of the radio button group (default is `null`).
  /// - [rules]: The list of validation rules to apply to the radio button group field (default is an empty list).
  RadioGroupFieldState(
      this.radioButtons, {
        required String label,
        T? value,
        List<ValidationRule<T?>> rules = const [],
      }) : super(value: value, label: label, rules: rules);
}
