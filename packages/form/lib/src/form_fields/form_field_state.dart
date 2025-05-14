import 'package:bond_form/src/validation/rules.dart';
import 'package:meta/meta.dart' show nonVirtual;

part 'disposable.dart';

/// Represents the state of a form field.
///
/// A form field can have a generic type `T` for its value.
/// such as the current value, error message, label, validation rules, and
/// whether it has been touched or should validate on updates.
abstract class FormFieldState<T> {
  /// The current value of the form field.
  final T value;

  /// The error message associated with the form field, if any.
  final String? error;

  /// The label or name of the form field.
  final String label;

  /// The list of validation rules to apply to the form field.
  final List<ValidationRule<T>> rules;

  /// Indicates whether validation should occur when the form field is updated.
  final bool validateOnUpdate;

  /// Indicates whether the form field has been touched (interacted with) by the user.
  final bool touched;

  /// Creates a new instance of [FormFieldState].
  ///
  /// - [value] The initial value of the form field.
  /// - [error] An optional error message initially associated with the field.
  /// - [label] The label or name of the form field (required).
  /// - [touched] Indicates whether the field has been touched (default is `false`).
  /// - [validateOnUpdate] Indicates whether validation should occur on updates (default is `true`).
  /// - [rules] The list of validation rules to apply to the form field (default is an empty list).
  FormFieldState({
    required this.value,
    this.error,
    required this.label,
    this.touched = false,
    this.validateOnUpdate = true,
    this.rules = const [],
  });

  /// Validates the form field against its validation rules.
  ///
  /// - [fields] A map of form field states for cross-field validation.
  ///
  /// Returns an error message if validation fails, otherwise returns `null`.
  @nonVirtual
  String? validate(Map<String, FormFieldState> fields) {
    final optionalRule = rules.whereType<Optional>().firstOrNull;
    if (optionalRule != null) {
      if (optionalRule.validate(value, fields)) {
        return null; // No validation error, skip other rules
      }
    }

    // Validate against all rules
    for (final rule in rules) {
      if (!(rule is Optional) && !rule.validate(value, fields)) {
        return rule.message(label); // Return the first error message
      }
    }

    return null; // All validations passed
  }

  /// Creates a new [FormFieldState] object by copying the existing state
  /// and replacing the specified fields with new values.
  ///
  /// This method returns a new object that has the same state as the current
  /// object, except with the updated fields.
  ///
  /// [value] The new value for the form field.
  /// [error] The new error string for the form field.
  /// [label] The new label string for the form field.
  /// [touched] The new boolean value indicating whether the field has been touched.
  /// [validateOnUpdate] The new boolean value to indicate whether to validate on update.
  /// [rules] The new list of [ValidationRule] objects for the form field.
  ///
  /// Returns a new [FormFieldState] object with updated fields.
  FormFieldState<T> copyWith({
    T? value,
    String? error,
    String? label,
    bool? touched,
    bool? validateOnUpdate,
    List<ValidationRule<T>>? rules,
  });

  /// A null-tolerant version of `copyWith`, allowing you to **explicitly** set fields to `null`.
  ///
  /// This is useful for form reset behaviors like clearing a field's value or removing its error.
  FormFieldState<T> copyWithNullable({
    T? value,
    String? error,
  }) {
    ;
    return copyWith(
      value: value,
      error: error,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FormFieldState &&
          runtimeType == other.runtimeType &&
          value == other.value &&
          error == other.error &&
          label == other.label &&
          rules == other.rules &&
          validateOnUpdate == other.validateOnUpdate &&
          touched == other.touched;

  @override
  int get hashCode =>
      value.hashCode ^
      error.hashCode ^
      label.hashCode ^
      rules.hashCode ^
      validateOnUpdate.hashCode ^
      touched.hashCode;
}
