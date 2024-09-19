import 'dart:async';

import 'package:bond_form/bond_form.dart';
import 'package:riverpod/riverpod.dart';

/// A state notifier for managing a multi-step form using Riverpod.
///
/// This class extends [AutoDisposeNotifier] to automatically dispose of
/// state when it's no longer needed, making it suitable for managing state in
/// Flutter applications where memory management is crucial. It implements the
/// base form controller and stepper form controller to provide form functionality
/// for forms that are divided into multiple steps.
///
/// Type Parameters:
/// - [Success] The type representing a successful result of the form submission.
/// - [Failure] The type representing the failure case, which extends [Error].
abstract class AutoDisposeStepperFormStateNotifier<Success,
        Failure extends Error>
    extends AutoDisposeNotifier<StepperFormState<Success, Failure>>
    with
        BaseFormController<Success, Failure,
            StepperFormState<Success, Failure>>,
        StepperFormController<Success, Failure> {
  /// A flag indicating whether the validation should stop on encountering the first error.
  final bool stopOnFirstError;

  /// Constructor to initialize [AutoDisposeStepperFormStateNotifier].
  ///
  /// - [stopOnFirstError] Whether validation should stop on the first encountered error.
  AutoDisposeStepperFormStateNotifier({
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
  /// Constructs the initial form state by combining states from individual step controllers.
  @override
  StepperFormState<Success, Failure> build() =>
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
