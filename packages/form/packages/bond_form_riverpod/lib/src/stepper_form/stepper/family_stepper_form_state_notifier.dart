import 'dart:async';

import 'package:bond_form/bond_form.dart';
import 'package:riverpod/riverpod.dart';

/// A state notifier for managing a multi-step form with family support using Riverpod.
///
/// This class extends [FamilyNotifier] to manage state for different instances of a family
/// of related objects. It is designed to handle the state of a step-by-step form process,
/// using Riverbed's state management capabilities, while ensuring memory efficiency by
/// automatically disposing of state when no longer needed.
///
/// Type Parameters:
/// - [Success] The type representing a successful result of the form submission.
/// - [Failure] The type representing the failure case, which extends [Error].
/// - [Arg] The argument type passed to the family provider.
abstract class FamilyStepperFormStateNotifier<Success, Failure extends Error,
        Arg> extends FamilyNotifier<StepperFormState<Success, Failure>, Arg>
    with
        BaseFormController<Success, Failure,
            StepperFormState<Success, Failure>>,
        StepperFormController<Success, Failure> {
  /// A flag indicating whether the validation should stop on encountering the first error.
  final bool stopOnFirstError;

  /// Constructor to initialize [FamilyStepperFormStateNotifier].
  ///
  /// - [stopOnFirstError] Whether validation should stop on the first encountered error.
  FamilyStepperFormStateNotifier({
    this.stopOnFirstError = false,
  });

  @override
  StepperFormState<Success, Failure> get state => super.state;

  @override
  set state(StepperFormState<Success, Failure> newState) {
    super.state = newState;
  }

  /// Builds the initial [StepperFormState] for the notifier.
  ///
  /// Constructs the initial form state by combining states from individual step controllers
  /// using the provided [arg] argument.
  ///
  /// - [arg] The argument passed to the family provider.
  @override
  StepperFormState<Success, Failure> build(Arg arg) =>
      StepperFormState<Success, Failure>.fromSteps(
        parent: this,
        steps: steps,
      );

  /// To be implemented by subclasses, specifying the behavior when the form is submitted.
  ///
  /// This method should define what happens upon form submission, such as API calls,
  /// data persistence, or any other necessary logic.
  @override
  Future<Success> onSubmit();
}
