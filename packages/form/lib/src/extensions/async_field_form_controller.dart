import 'dart:developer';

import 'package:bond_form/bond_form.dart';

/// Extension on [BaseFormController] to handle resolving asynchronous hidden fields.
///
/// Provides a method to resolve the value of an async hidden field and update its state
/// within the form controller. If the future completes successfully, the field's value
/// is updated and any error is cleared. If the future fails, the error is logged and
/// the field's error state is updated.
///
/// Example usage:
/// ```dart
/// final value = await formController.resolveAsyncField<String>('myAsyncField');
/// ```
extension AsyncFieldFormController on BaseFormController {
  /// Resolves the value of an asynchronous hidden field and updates its state.
  ///
  /// - Parameter [fieldName] The name of the field to resolve.
  /// - Returns: a [Future<T>] containing the resolved value or throws if the future fails.
  /// - Throws: [ArgumentError] if the field doesn't exist or is not an async hidden field.
  /// - Throws: [Exception] if the future fails to resolve.
  Future<T> resolveAsyncField<T>(String fieldName) {
    final fieldState = state.asyncHiddenField<T>(fieldName);

    return fieldState.pendingValue.then((resolvedValue) {
      // Update the field with the resolved value and clear any previous error
      state.fields[fieldName] =
          fieldState.copyWith(value: resolvedValue).updateError(null);
      return resolvedValue;
    }).catchError((error, stack) {
      log(
        '⚠️ Hidden Async field $fieldName failed to resolve: $error',
        stackTrace: stack,
      );
      state.fields[fieldName] = fieldState.updateError(error.toString());
      throw error; // Re-throw so caller can catch
    });
  }
}
