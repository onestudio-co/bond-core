import 'package:bond_form/bond_form.dart';
import 'package:riverpod/riverpod.dart';
import 'dart:async';

/// A state notifier for managing the state of a single step in a stepper form.
///
/// The [StepFormStateNotifier] class extends [Notifier] to provide state management
/// for a single step in a multi-step form. This class is designed to handle form state,
/// validation, and submission logic for a specific step in a stepper form sequence.
///
/// Type Parameters:
/// - [Success] The data type representing the result of a successful form submission.
/// - [Failure] The error type that extends [Error], representing failure cases of form submission.
abstract class StepFormStateNotifier<Success, Failure extends Error>
    extends Notifier<BondFormState<Success, Failure>>
    with
        BaseFormController<Success, Failure, BondFormState<Success, Failure>>,
        StepFormController<Success, Failure> {
  /// A flag indicating if the validation should stop on encountering the first error.
  final bool stopOnFirstError;

  /// Constructor to initialize the [StepFormStateNotifier].
  ///
  /// - [stopOnFirstError]: Optional flag indicating if the validation should stop on encountering the first error.
  StepFormStateNotifier({
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
  /// This method initializes a new [BondFormState] with the fields managed by this form controller.
  ///
  /// Returns:
  /// A new instance of [BondFormState] with the form fields.
  @override
  BondFormState<Success, Failure> build() =>
      BondFormState<Success, Failure>(fields: fields());

  /// Abstract method to handle form submission logic.
  ///
  /// This method should be implemented by subclasses to define what happens when the form is submitted.
  /// It is expected to return a [Future] that completes with a [Success] result if the submission is successful,
  /// or throws an exception if it fails.
  @override
  Future<Success> onSubmit();
}
