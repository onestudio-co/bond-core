import 'dart:async';

import 'package:bond_form/bond_form.dart';
import 'package:riverpod/riverpod.dart';

/// A state notifier for managing the state of a single step in a family-based stepper form,
/// using a parameterized argument and with automatic disposal.
///
/// The [FamilyStepFormStateNotifier] class extends [FamilyNotifier] to provide state management
/// for a single step in a multi-step form, with an argument parameter [Arg]. This class
/// is designed to manage the form state, validation, and submission logic for a specific step
/// in a family-based context where different instances may use different parameters.
///
/// Type Parameters:
/// - [Success] The data type representing the result of a successful form submission.
/// - [Failure] The error type that extends [Error], representing failure cases of form submission.
/// - [Arg] The type of the argument that will be passed to the family notifier.
abstract class FamilyStepFormStateNotifier<Success, Failure extends Error, Arg>
    extends FamilyNotifier<BondFormState<Success, Failure>, Arg>
    with
        BaseFormController<Success, Failure, BondFormState<Success, Failure>>,
        StepFormController<Success, Failure> {
  /// A flag indicating if the validation should stop on encountering the first error.
  final bool stopOnFirstError;

  /// Constructor to initialize the [FamilyStepFormStateNotifier].
  ///
  /// - [stopOnFirstError]: Optional flag indicating if the validation should stop on encountering the first error.
  FamilyStepFormStateNotifier({
    this.stopOnFirstError = false,
  });

  @override
  BondFormState<Success, Failure> get state => super.state;

  @override
  set state(BondFormState<Success, Failure> newState) {
    super.state = newState;
  }

  /// Builds the initial state of the form using the provided argument [arg].
  ///
  /// This method creates a new [BondFormState] initialized with the fields managed by this form controller.
  ///
  /// Parameters:
  /// - [arg]: The argument of type [Arg] used to initialize the state.
  ///
  /// Returns:
  /// A new instance of [BondFormState] with the form fields.
  @override
  BondFormState<Success, Failure> build(Arg arg) {
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
