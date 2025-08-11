import 'package:bloc/bloc.dart';
import 'package:bond_form/bond_form.dart';

/// A lightweight base Cubit for building Bond Form–backed forms with BLoC.
///
/// `FormCubit` wires Bond Form’s controller mixins into a `Cubit`, so you can:
/// - define your **field schema** once (via [fields])
/// - get a fully functional [BondFormState] in [state]
/// - use helpers from [FormController] (e.g. `validate`,`submit`,`updateValue`)
///
/// ### Usage
/// ```dart
/// class LoginFormCubit extends FormCubit<void, FormError> {
///   @override
///   Map<String, FormFieldState> fields() => {
///     'email': TextFieldState<String>(
///       '',
///       label: 'email',
///       rules: const [RequiredString(), EmailRule()],
///     ),
///     'password': TextFieldState<String>(
///       '',
///       label: 'password',
///       rules: const [RequiredString(), MinLengthString(8)],
///     ),
///   };
///
///   @override
///   Future<void> onSubmit() async {
///   return bondFire.post("auth/login").body(body()).execute();
///   }
/// }
/// ```
///
/// Subclasses **must** override:
/// - [fields] — to provide the initial map of field states.
/// - [onSubmit] (inherited from [FormController]) — to perform submission.
abstract class FormCubit<Success, Failure extends Error>
    extends Cubit<BondFormState<Success, Failure>>
    with
        BaseFormController<Success, Failure, BondFormState<Success, Failure>>,
        FieldChangeTrackingMixin<Success, Failure>,
        FormController<Success, Failure> {
  /// Creates a [FormCubit] and initializes the form state using [fields].
  ///
  FormCubit() : super(BondFormState<Success, Failure>(fields: const {})) {
    // Initialize the form with fields() and start tracking changes.
    state = BondFormState<Success, Failure>(fields: fields());
    initializeFieldTracking();
  }

  /// Current Bond Form state.
  ///
  /// Overridden only to expose the more specific type.
  @override
  BondFormState<Success, Failure> get state => super.state;

  /// Emits a new Bond Form state.
  ///
  /// Prefer using the helpers from [FormController] and
  /// [BaseFormController] (e.g., `updateValue`, `updateError`, `copyWith`)
  /// to modify state safely; then assign the result to [state] to notify
  /// listeners.
  @override
  set state(BondFormState<Success, Failure> newState) {
    emit(newState);
  }

  /// Disposes resources created by the Bond Form mixins, then closes the Cubit.
  @override
  Future<void> close() async {
    dispose(); // from BaseFormController / FieldChangeTrackingMixin
    await super.close();
  }
}
