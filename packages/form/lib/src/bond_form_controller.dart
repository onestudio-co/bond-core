import 'dart:developer';

import 'package:bond_form/bond_form.dart';

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
  ///   - [fieldName]: The name of the field to update.
  ///   - [value]: The new value for the field.
  void update<T extends FormFieldState<G>, G>(String fieldName, G value) {
    var field = state.get<T, G>(fieldName);
    field.value = value;
    field.touched = true;
    state.fields[fieldName] = field;
    final status =
        _allValid ? BondFormStateStatus.valid : BondFormStateStatus.invalid;
    state = state.copyWith(
      fields: Map.from(state.fields),
      status: status,
    );
  }

  /// A private getter to check if all fields in the form are valid.
  bool get _allValid {
    var allValid = true;
    for (final fieldName in state.fields.keys) {
      final field = state.get(fieldName);
      final error = field.validate(state.fields);
      if (error != null) {
        allValid = false;
        if (field.validateOnUpdate && field.touched) {
          field.error = field.validate(state.fields);
        }
        if (stopOnFirstError) {
          break;
        }
      } else {
        field.error = null;
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
      field.touched = true;
      state.fields[fieldName] = field;
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
      } catch (e) {
        state = state.copyWith(
          status: BondFormStateStatus.failed,
          failure: e as Failure,
        );
      }
    } else {
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
}
