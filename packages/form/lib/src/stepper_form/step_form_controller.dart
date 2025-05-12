import 'package:bond_form/bond_form.dart';
import 'package:meta/meta.dart';

/// A mixin to manage the state and navigation of individual steps in a multi-step form.
///
/// This mixin provides methods to navigate to the next and previous steps
/// and handles form submission specific to each step.
///
/// Type Parameters:
/// - [Success] The type representing a successful result of the form submission.
/// - [Failure] The type representing the failure case, which extends [Error].
mixin StepFormController<Success, Failure extends Error>
    on BaseFormController<Success, Failure, BondFormState<Success, Failure>> {
  /// A reference to the parent [StepperFormController] that manages the entire multi-step form.
  @internal
  late StepperFormController parent;

  /// Submits the current step and advances to the next step if successful.
  ///
  /// Calls [submit] to perform the submission of the current step.
  /// If the submission is successful (`BondFormStateStatus.submitted`), it advances to the next step.
  Future<void> next() async {
    await submit();
    if (state.status == BondFormStateStatus.submitted) {
      parent.next();
    }
  }

  /// Navigates to the previous step in the multi-step form.
  ///
  /// Calls the parent controller's [previous] method to go back to the previous step.
  void previous() {
    parent.previous();
  }

  /// Handles the form submission for the current step.
  ///
  /// Override this method in each step to define what should happen when the step is submitted.
  /// Currently, it does nothing and returns a completed [Future].
  @override
  Future<Success> onSubmit() {
    // Implement specific submission logic for this step if needed.
    return Future.value();
  }

  @protected
  void dispose() {
    for (final field in fields().values.whereType<Disposable>()) {
      field.dispose();
    }
  }
}
