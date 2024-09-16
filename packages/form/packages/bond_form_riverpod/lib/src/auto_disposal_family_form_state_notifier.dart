import 'dart:async';

import 'package:bond_form/bond_form.dart';
import 'package:riverpod/riverpod.dart';

/// `AutoDisposeFormStateNotifier` is an abstract class that manages the form state.
/// It extends `AutoDisposeFamilyNotifier` to automatically manage resources and provide argument support.
/// the `FormController` mixin to provide functionalities related to form management.
///
/// This class is intended to be used as the foundation for creating form-based
/// state management solutions that need automatic resource cleanup.
///
///  Type Parameters:
/// - [Success] The type that will represent successful form submission.
/// - [Failure] The type that extends [Error] to represent failure in form submission.
/// - [Arg] The type of the argument that will be passed to the form.
abstract class AutoDisposeFamilyFormStateNotifier<Success,
        Failure extends Error, Arg>
    extends AutoDisposeFamilyNotifier<BondFormState<Success, Failure>, Arg>
    with
        BaseFormController<Success, Failure, BondFormState<Success, Failure>>,
        FormController<Success, Failure> {
  /// Determines whether the validation should stop at the first error.
  final bool stopOnFirstError;

  /// Constructor for FormStateNotifier, defaults to not stopping at the first error.
  AutoDisposeFamilyFormStateNotifier({
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
  BondFormState<Success, Failure> build(Arg arg) =>
      BondFormState<Success, Failure>(fields: fields());

  /// An abstract method to be implemented by the subclass,
  /// detailing what should happen when the form is submitted.
  @override
  Future<Success> onSubmit();
}
