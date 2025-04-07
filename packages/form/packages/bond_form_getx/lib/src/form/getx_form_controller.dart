import 'package:get/get.dart';
  import 'package:bond_form/bond_form.dart';

  /// A Bond-compatible form controller wrapped around a GetxController instance.
  ///
  /// This abstract class extends `GetxController` and mixes in `BaseFormController`
  /// and `FormController` to manage the form state using Getx's reactive state management.
  ///
  /// Type Parameters:
  /// - `Success`: The type representing a successful form submission.
  /// - `Failure`: The type representing a failed form submission, which must extend `Error`.
  abstract class GetxFormController<Success, Failure extends Error>
      extends GetxController
      with
          BaseFormController<Success, Failure, BondFormState<Success, Failure>>,
          FormController<Success, Failure> {

    /// The GetxController instance that manages the form state.
    ///
    /// This is a reactive variable that holds the current state of the form.
    final Rx<BondFormState<Success, Failure>> formState =
        Rx<BondFormState<Success, Failure>>(
      BondFormState<Success, Failure>(
        fields: {},
      ),
    );

    /// Gets the current state of the form.
    @override
    BondFormState<Success, Failure> get state => formState.value;

    /// Sets a new state for the form.
    ///
    /// This updates the reactive `formState` variable with the new state.
    @override
    set state(BondFormState<Success, Failure> newState) {
      formState.value = newState;
    }

    /// Initializes the form controller.
    ///
    /// This method is called when the controller is initialized. It sets the initial
    /// state of the form with the provided fields.
    @override
    void onInit() {
      super.onInit();
      // Initialize the form state with the provided fields
      formState.value = BondFormState<Success, Failure>(
        fields: fields(),
      );
    }
  }