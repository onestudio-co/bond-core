import 'package:bond_form/bond_form.dart';
import 'package:meta/meta.dart';

/// A mixin to extend the functionality of a form controller by inheriting
/// the base methods for managing form state, field updates, validation,
/// and form submission.
///
/// The `FormController` provides a simplified way to manage forms, ensuring
/// that all the fundamental functionalities such as updating fields, validating
/// input, and handling form submission are readily available. It extends the
/// `BaseFormController` to provide these core capabilities.
///
/// Type Parameters:
///   - [Success] The data type that represents the result of a successful form submission.
///   - [Failure] The error type that extends [Error] representing the failure cases of form submission.
///
/// Usage:
///   Use this mixin with any class that needs to manage form state and logic.
///   This mixin provides all essential methods and properties for interacting
///   with a form's fields and its state, allowing for a streamlined implementation.
mixin FormController<Success, Failure extends Error>
    on BaseFormController<Success, Failure, BondFormState<Success, Failure>> {
  // Additional form-specific methods or properties can be added here if needed

  /// Disposes resources used by the form controller.
  ///
  /// This method removes listeners from all `TextFieldState` fields and disposes
  /// any fields that implement the `Disposable` interface. It should be called
  /// when the controller is no longer needed to prevent memory leaks.
  @protected
  void dispose() {
    for (final entry in state.fields.entries) {
      if (entry.value is TextFieldState) {
        removeTextFieldListener(entry.key);
      }
    }
    for (final field in state.fields.values.whereType<Disposable>()) {
      field.dispose();
    }
  }
}
