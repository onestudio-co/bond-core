import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

/// Represents the state of a date input form field.
///
/// A date input form field extends the [FormFieldState] class, providing
/// a way to manage the state of a date input.
class DateFieldState extends FormFieldState<DateTime?> {
  /// Creates a new instance of [DateFieldState].
  ///
  /// - [value]: The initial date value of the field.
  /// - [label]: The label or name of the date input form field (required).
  /// - [rules]: The list of validation rules to apply to the date field (default is an empty list).
  DateFieldState(
    DateTime? value, {
    required String label,
    String? error,
    List<ValidationRule<DateTime?>> rules = const [],
  }) : super(
          value: value,
          label: label,
          error: error,
          rules: rules,
        );

  @override
  DateFieldState copyWith({
    DateTime? value,
    String? error,
    String? label,
    bool? touched,
    bool? validateOnUpdate,
    List<ValidationRule<DateTime?>>? rules,
  }) {
    return DateFieldState(
      value ?? this.value,
      error: error ?? this.error,
      label: label ?? this.label,
      rules: rules ?? this.rules,
    );
  }
}
