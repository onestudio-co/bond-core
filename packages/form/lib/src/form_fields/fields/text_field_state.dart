import 'package:bond_form/src/form_fields/form_field_state.dart';
import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:flutter/widgets.dart' as widgets;
import 'package:meta/meta.dart';

/// Represents the state of a text input form field.
///
/// A text input form field extends the [FormFieldState] class and uses a
/// [TextEditingController] to maintain a live connection with a `TextFormField`.
class TextFieldState extends FormFieldState<String?> with Disposable {
  /// A controller to manage the current text being edited.
  ///
  /// This controller is auto-initialized with the value passed to [TextFieldState].
  /// You can bind this directly to a [TextFormField] or [TextField] widget.
  final widgets.TextEditingController _controller;

  @internal
  widgets.TextEditingController get controller => _controller;

  /// Creates a new instance of [TextFieldState].
  ///
  /// - [value]: The initial value of the text input field.
  /// - [label]: The label or name of the text input form field (required).
  /// - [rules]: The list of validation rules to apply to the text field (default is an empty list).
  /// - [validateOnUpdate]: Indicates whether validation should occur on updates (default is `true`).
  /// - [touched]: Indicates whether the field has been touched (interacted with) by the user (default is `false`).
  /// - [controller]: Optionally provide your own [TextEditingController]. If not provided, one will be created.
  TextFieldState(
    String? value, {
    required String label,
    String? error,
    List<ValidationRule<String?>> rules = const [],
    bool validateOnUpdate = true,
    bool touched = false,
    widgets.TextEditingController? controller,
  })  : _controller = controller ??
            widgets.TextEditingController.fromValue(
              widgets.TextEditingValue(
                text: value ?? '',
                selection: value != null
                    ? widgets.TextSelection.collapsed(offset: value.length)
                    : const widgets.TextSelection.collapsed(offset: 0),
              ),
            ),
        super(
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
      controller: _controller,
    );
  }

  @override
  TextFieldState updateError(String? error) {
    return TextFieldState(
      value,
      error: error,
      label: label,
      rules: rules,
      touched: touched,
      validateOnUpdate: validateOnUpdate,
      controller: controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
  }
}
