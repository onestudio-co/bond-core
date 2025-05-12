import 'dart:async';

import 'package:bond_form/bond_form.dart';
import 'package:riverpod/riverpod.dart';

/// A class to manage form state, extending a notifier to notify its subscribers
/// of changes, and using the FormController mixin for form operations.
///
/// Type Parameters:
///   - [Success] The data type that represents the result of a successful form submission.
///   - [Failure] The error type that extends [Error] representing the failure cases of form submission.
abstract class FormStateNotifier<Success, Failure extends Error>
    extends Notifier<BondFormState<Success, Failure>>
    with
        BaseFormController<Success, Failure, BondFormState<Success, Failure>>,
        FormController<Success, Failure> {
  /// Determines whether the validation should stop at the first error.
  final bool stopOnFirstError;

  /// Constructor for FormStateNotifier, defaults to not stopping at the first error.
  FormStateNotifier({
    this.stopOnFirstError = false,
  });

  /// Gets the current state of the form.
  @override
  BondFormState<Success, Failure> get state => super.state;

  /// Sets the new state for the form.
  @override
  set state(BondFormState<Success, Failure> newState) {
    super.state = newState;
  }

  /// Builds the initial state for the form.
  @override
  BondFormState<Success, Failure> build() {
    ref.onDispose(dispose);
    return BondFormState<Success, Failure>(fields: fields());
  }

  /// An abstract method to be implemented by the subclass,
  /// detailing what should happen when the form is submitted.
  @override
  Future<Success> onSubmit();
}
