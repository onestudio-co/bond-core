import 'package:bond_form/src/form_fields/form_field_state.dart';
import 'package:bond_form/src/validation/validation_rule.dart';

/// Represents the state of a hidden field with an asynchronously loaded value.
///
/// An `AsyncHiddenFieldState` extends the [FormFieldState] class, providing
/// a way to manage the state of a hidden input whose value is loaded asynchronously.
class AsyncHiddenFieldState<T> extends FormFieldState<T> {
  final Future<T> pendingValue;

  /// Creates a new instance of [AsyncHiddenFieldState].
  ///
  /// - [value] The value associated with the hidden field (optional).
  /// - [pendingValue] The future value that will be loaded asynchronously.
  AsyncHiddenFieldState(
    T value, {
    required this.pendingValue,
  }) : super(
          value: value,
          label: '',
          error: null,
          rules: const [],
        );

  @override
  AsyncHiddenFieldState<T> copyWith({
    T? value,
    Future<T>? futureValue,
    String? error,
    String? label,
    bool? touched,
    bool? validateOnUpdate,
    List<ValidationRule<T>>? rules,
  }) {
    return AsyncHiddenFieldState<T>(
      value ?? this.value,
      pendingValue: futureValue ?? this.pendingValue,
    );
  }

  @override
  AsyncHiddenFieldState<T> copyWithNullable({
    T? value,
    Future<T>? futureValue,
  }) {
    return AsyncHiddenFieldState<T>(
      value as T,
      pendingValue: futureValue ?? this.pendingValue,
    );
  }
}
