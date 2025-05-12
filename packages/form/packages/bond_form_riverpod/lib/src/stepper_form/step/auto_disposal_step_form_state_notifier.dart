import 'dart:async';

import 'package:bond_form/bond_form.dart';
import 'package:riverpod/riverpod.dart';

/// A state notifier for managing the state of a single step in a stepper form,
/// with automatic disposal when no longer needed.
///
/// The [AutoDisposeStepFormStateNotifier] class extends [AutoDisposeNotifier] to provide
/// automatic resource management for a single step in a multi-step form. It uses the [BondFormState]
/// to manage the form state, validation, and submission logic for that step. This class can be used
/// to define a step in a stepper form that will be automatically disposed of when it is no longer needed.
///
/// Type Parameters:
/// - [Success] The data type that represents the result of a successful form submission.
/// - [Failure] The error type that extends [Error], representing failure cases of form submission.
abstract class AutoDisposeStepFormStateNotifier<Success, Failure extends Error>
    extends AutoDisposeNotifier<BondFormState<Success, Failure>>
    with
        BaseFormController<Success, Failure, BondFormState<Success, Failure>>,
        StepFormController<Success, Failure> {
  /// A flag indicating if the validation should stop on encountering the first error.
  final bool stopOnFirstError;

  /// Constructor to initialize [AutoDisposeStepFormStateNotifier].
  ///
  /// - [stopOnFirstError] Optional flag indicating if the validation should stop on encountering the first error.
  AutoDisposeStepFormStateNotifier({
    this.stopOnFirstError = false,
  });

  @override
  BondFormState<Success, Failure> get state => super.state;

  @override
  set state(BondFormState<Success, Failure> newState) {
    super.state = newState;
  }

  /// Builds the initial state of the form.
  ///
  /// Returns a new [BondFormState] initialized with the fields managed by this form controller.
  @override
  BondFormState<Success, Failure> build() {
    ref.onDispose(dispose);
    return BondFormState<Success, Failure>(fields: fields());
  }

  /// Abstract method to handle form submission logic.
  ///
  /// This method should be implemented by subclasses to define what happens when the form is submitted.
  /// It is expected to return a [Future] that completes with a [Success] result if the submission is successful,
  /// or throws an exception if it fails.
  @override
  Future<Success> onSubmit();
}
