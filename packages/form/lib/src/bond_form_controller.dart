import 'dart:developer';

import 'package:bond_form/bond_form.dart';
import 'package:bond_form/src/validation/has_validation_errors.dart';

/// A mixin to manage the state and logic of a form.
///
/// The mixin defines methods for updating fields, validating the form,
/// and handling form submission.
///
/// Type Parameters:
///   - [Success]: The data type that represents the result of a successful form submission.
///   - [Failure]: The error type that extends [Error] representing the failure cases of form submission.
mixin FormController<Success, Failure extends Error> {
  /// Returns the current state of the form.
  BondFormState<Success, Failure> get state;

  /// Sets the new state for the form.
  set state(BondFormState<Success, Failure> newState);

  /// Returns the map of field names to their corresponding `FormFieldState`.
  Map<String, FormFieldState> fields();

  /// A flag indicating if the validation should stop on encountering the first error.
  bool stopOnFirstError = false;

  /// Updates the field value and status.
  ///
  /// Parameters:
  ///   - [fieldName] The name of the field to update.
  ///   - [value] The new value for the field.
  void update<T extends FormFieldState<G>, G>(String fieldName, G value) {
    var field = state.get<T, G>(fieldName);
    state.fields[fieldName] = field.copyWith(
      value: value,
      touched: true,
    );
    final status =
        _allValid ? BondFormStateStatus.valid : BondFormStateStatus.invalid;
    state = state.copyWith(
      fields: Map.from(state.fields),
      status: status,
    );
  }

  /// Validates all fields in the form.
  void validate() {
    for (final fieldName in state.fields.keys) {
      final field = state.get(fieldName);
      state.fields[fieldName] = field.copyWith(touched: true);
    }
    if (_allValid) {
      state = state.copyWith(
        fields: Map.from(state.fields),
        status: BondFormStateStatus.valid,
      );
    } else {
      for (final fieldEntry in state.fields.entries) {
        final field = fieldEntry.value;
        final error = field.validate(state.fields);
        state.fields[fieldEntry.key] = field.updateError(error);
      }
      state = state.copyWith(
        fields: Map.from(state.fields),
        status: BondFormStateStatus.invalid,
      );
      final errors = state.fields.values
          .where((element) => element.error != null)
          .map((e) => '*${e.error}*')
          .join('\n');
      log('Form is not on valid state\n$errors');
    }
  }

  /// A private getter to check if all fields in the form are valid.
  bool get _allValid {
    var allValid = true;
    for (final fieldEntry in state.fields.entries) {
      final field = fieldEntry.value;
      final error = field.validate(state.fields);
      if (error != null) {
        allValid = false;
        if (field.touched) {
          state.fields[fieldEntry.key] = field.updateError(error);
        }
        if (stopOnFirstError) {
          break;
        }
      } else {
        state.fields[fieldEntry.key] = field.updateError(null);
      }
    }
    return allValid;
  }

  /// Initiates the form submission process.
  ///
  /// This method calls the [onSubmit] method and updates the form state accordingly.
  Future<void> submit() => _onSubmit();

  /// To be implemented by the subclass, detailing what should happen when a form is submitted.
  Future<Success> onSubmit();

  /// Internal method to handle form submission.
  ///
  /// This method sets all fields to "touched", validates all fields,
  /// and then either submits the form or logs errors.
  Future<void> _onSubmit() async {
    for (final fieldName in state.fields.keys) {
      final field = state.get(fieldName);
      state.fields[fieldName] = field.copyWith(touched: true);
    }
    if (_allValid) {
      state = state.copyWith(
        fields: Map.from(state.fields),
        status: BondFormStateStatus.submitting,
      );
      try {
        final result = await onSubmit();
        state = state.copyWith(
          status: BondFormStateStatus.submitted,
          success: result,
        );
      } catch (error) {
        if (error is HasValidationErrors) {
          _updateValidationErrors(error.errors);
        } else {
          state = state.copyWith(
            status: BondFormStateStatus.failed,
            failure: error as Failure,
          );
        }
      }
    } else {
      for (final fieldEntry in state.fields.entries) {
        final field = fieldEntry.value;
        final error = field.validate(state.fields);
        state.fields[fieldEntry.key] = field.updateError(error);
      }
      state = state.copyWith(
        fields: Map.from(state.fields),
        status: BondFormStateStatus.invalid,
      );
      final errors = state.fields.values
          .where((element) => element.error != null)
          .map((e) => '*${e.error}*')
          .join('\n');
      log('Form is not on valid state\n$errors');
    }
  }

  /// Internal method to update validation errors for form fields.
  ///
  /// This method updates the validation errors for each form field based on the provided [errors] map.
  /// It iterates through the fields, retrieves the corresponding error messages from the map,
  /// and updates the error state of each field accordingly.
  ///
  /// - Parameter [errors] A map containing field names as keys and lists of error messages as values.
  void _updateValidationErrors(Map<String, List<String>> errors) {
    for (final fieldEntry in state.fields.entries) {
      final field = fieldEntry.value;
      final error = errors[fieldEntry.key]?.join('\n');
      state.fields[fieldEntry.key] = field.updateError(error);
    }
    state = state.copyWith(
      fields: Map.from(state.fields),
      status: BondFormStateStatus.invalid,
    );
  }

  /// Clears the form state and resets it to its initial pristine state.
  ///
  /// This method resets all form fields to their initial state, clears any success or failure information,
  /// and sets the form status to 'pristine'.
  void clear() {
    state = state.copyWith(
      fields: Map.from(fields()),
      status: BondFormStateStatus.pristine,
      success: null,
      failure: null,
    );
  }
}
