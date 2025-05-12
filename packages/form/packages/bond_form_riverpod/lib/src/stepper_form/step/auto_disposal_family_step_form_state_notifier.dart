import 'dart:async';

import 'package:bond_form/bond_form.dart';
import 'package:riverpod/riverpod.dart';

/// A state notifier for managing a single step in a multi-step form with automatic disposal.
///
/// This class extends [AutoDisposeFamilyNotifier] and implements the [BaseFormController] and
/// [StepFormController] mixins to handle the state and logic of an individual form step. It is
/// designed for use with Riverpod's family providers, allowing each step to have its own argument
/// ([Arg]) and state management.
///
/// Type Parameters:
/// - [Success] The data type representing the result of a successful form submission.
/// - [Failure] The error type that extends [Error] representing the failure cases of form submission.
/// - [Arg] The argument type for the family provider, used to build the initial state.
abstract class AutoDisposeFamilyStepFormStateNotifier<Success,
        Failure extends Error, Arg>
    extends AutoDisposeFamilyNotifier<BondFormState<Success, Failure>, Arg>
    with
        BaseFormController<Success, Failure, BondFormState<Success, Failure>>,
        StepFormController<Success, Failure> {
  /// A flag indicating whether the validation process should stop on the first encountered error.
  final bool stopOnFirstError;

  /// Constructor for [AutoDisposeFamilyStepFormStateNotifier].
  ///
  /// [stopOnFirstError] determines if the validation should halt on the first error.
  AutoDisposeFamilyStepFormStateNotifier({
    this.stopOnFirstError = false,
  });

  /// Gets the current state of the form.
  @override
  BondFormState<Success, Failure> get state => super.state;

  /// Sets a new state for the form.
  @override
  set state(BondFormState<Success, Failure> newState) {
    super.state = newState;
  }

  /// Builds the initial state for the form using the provided argument.
  ///
  /// [arg] is the argument passed by the family provider to initialize the state.
  /// Returns a new instance of [BondFormState] with the initial fields set.
  @override
  BondFormState<Success, Failure> build(Arg arg) {
    ref.onDispose(dispose);
    return BondFormState<Success, Failure>(fields: fields());
  }

  /// Submits the form and processes the form data.
  ///
  /// This method should be implemented by subclasses to define the specific submission logic.
  /// Returns a [Future] containing the result of the submission.
  @override
  Future<Success> onSubmit();
}
