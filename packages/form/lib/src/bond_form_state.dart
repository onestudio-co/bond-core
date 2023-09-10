import 'form_fields/form_field_state.dart';

/// Represents the different states a [BondFormState] can be in.
enum BondFormStateStatus {
  /// The form is in its initial pristine state, with no changes or validations.
  pristine,

  /// The form is valid and ready to be submitted.
  valid,

  /// The form has validation errors and is not ready for submission.
  invalid,

  /// The form is currently submitting its data.
  submitting,

  /// The form has been successfully submitted.
  submitted,

  /// The form submission has failed.
  failed,
}

/// Represents the state of a form with its fields and submission status.
class BondFormState<Success, Failure extends Error> {
  /// The map of field names to their corresponding state objects.
  final Map<String, FormFieldState> fields;

  /// The current status of the form.
  final BondFormStateStatus status;

  final Success? _success;
  final Failure? _failure;

  /// Creates a [BondFormState] with the provided parameters.
  ///
  /// - [fields]: A map of field names to their corresponding field state objects.
  /// - [status]: The current status of the form (default is [BondFormStateStatus.pristine]).
  /// - [success]: The success result of the form submission.
  /// - [failure]: The failure result of the form submission.
  BondFormState({
    required this.fields,
    this.status = BondFormStateStatus.pristine,
    Success? success,
    Failure? failure,
  })  : _success = success,
        _failure = failure;

  /// Gets the success result of the form submission.
  ///
  /// Throws a [StateError] if the form is not in the [BondFormStateStatus.submitted] state.
  Success get success {
    if (_success == null || status != BondFormStateStatus.submitted) {
      throw StateError(
          'Accessing success while form not successfully submitted');
    }
    return _success!;
  }

  /// Gets the failure result of the form submission.
  ///
  /// Throws a [StateError] if the form is not in the [BondFormStateStatus.failed] state.
  Failure get failure {
    if (_failure == null || status != BondFormStateStatus.failed) {
      throw StateError('Accessing failure while form not in failure state');
    }
    return _failure!;
  }

  /// Gets the state of a form field by its [fieldName].
  ///
  /// Throws an [ArgumentError] if no field with the specified [fieldName] is found.
  T get<T extends FormFieldState<G>, G>(String fieldName) {
    if (!fields.containsKey(fieldName)) {
      throw ArgumentError('No field found with name $fieldName');
    }
    return fields[fieldName] as T;
  }

  /// Gets the label for a form field by its [fieldName].
  String label<T extends FormFieldState<G>, G>(String fieldName) =>
      get<T, G>(fieldName).label;

  /// Gets the error message for a form field by its [fieldName].
  String? error<T extends FormFieldState<G>, G>(String fieldName) =>
      get<T, G>(fieldName).error;

  /// Allows accessing the state of a form field using subscript operator.
  FormFieldState operator [](String fieldName) => get(fieldName);

  /// Creates a copy of this [BondFormState] with optional parameter overrides.
  BondFormState<Success, Failure> copyWith({
    Map<String, FormFieldState>? fields,
    BondFormStateStatus? status,
    Success? success,
    Failure? failure,
  }) {
    return BondFormState<Success, Failure>(
      fields: fields ?? this.fields,
      status: status ?? this.status,
      success: success ?? this._success,
      failure: failure ?? this._failure,
    );
  }
}
