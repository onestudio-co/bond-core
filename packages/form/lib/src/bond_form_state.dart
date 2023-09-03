import 'form_fields/form_field_state.dart';

enum BondFormStateStatus {
  pristine,
  valid,
  invalid,
  submitting,
  submitted,
  failed,
}

class BondFormState<Success, Failure extends Error> {
  final Map<String, FormFieldState> fields;
  final BondFormStateStatus status;
  final Success? _success;
  final Failure? _failure;

  BondFormState({
    required this.fields,
    this.status = BondFormStateStatus.pristine,
    Success? success,
    Failure? failure,
  })  : _success = success,
        _failure = failure;

  Success get success {
    if (_success == null || status != BondFormStateStatus.submitted) {
      throw StateError(
          'Accessing success while form not successfully submitted');
    }
    return _success!;
  }

  Failure get failure {
    if (_failure == null || status != BondFormStateStatus.failed) {
      throw StateError('Accessing failure while form not in failure state');
    }
    return _failure!;
  }

  FormFieldState<T> get<T>(String fieldName) {
    if (!fields.containsKey(fieldName)) {
      throw ArgumentError('No field found with name $fieldName');
    }
    return fields[fieldName] as FormFieldState<T>;
  }

  String label<T>(String fieldName) => get<T>(fieldName).label;

  String? error<T>(String fieldName) => get<T>(fieldName).error;

  FormFieldState operator [](String fieldName) => get(fieldName);

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
