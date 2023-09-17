import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

/// Represents the state of a text input form field.
///
/// A text input form field extends the [FormFieldState] class, providing
/// a way to manage the state of a text input.
class TextFieldState extends FormFieldState<String?> {
  /// Creates a new instance of [TextFieldState].
  ///
  /// - [value]: The initial value of the text input field.
  /// - [label]: The label or name of the text input form field (required).
  /// - [rules]: The list of validation rules to apply to the text field (default is an empty list).
  /// - [validateOnUpdate]: Indicates whether validation should occur on updates (default is `true`).
  /// - [touched]: Indicates whether the field has been touched (interacted with) by the user (default is `false`).
  TextFieldState(
    String? value, {
    required String label,
    String? error,
    List<ValidationRule<String?>> rules = const [],
    bool validateOnUpdate = true,
    bool touched = false,
  }) : super(
          value: value,
          error: error,
          label: label,
          rules: rules,
          validateOnUpdate: validateOnUpdate,
          touched: touched,
        );

  @override
  TextFieldState copyWith({
    String? value,
    String? error,
    String? label,
    bool? touched,
    bool? validateOnUpdate,
    List<ValidationRule<String?>>? rules,
  }) {
    return TextFieldState(
      value ?? this.value,
      error: error ?? this.error,
      label: label ?? this.label,
      touched: touched ?? this.touched,
      validateOnUpdate: validateOnUpdate ?? this.validateOnUpdate,
      rules: rules ?? this.rules,
    );
  }
}
