import 'form_fields/form_field_state.dart';

class FormState {
  final Map<String, FormFieldState> _fields;
  final bool stopOnFirstError;

  FormState({
    required Map<String, FormFieldState> fields,
    this.stopOnFirstError = false,
  }) : _fields = fields;

  FormState copyWith({
    Map<String, FormFieldState>? fields,
    bool? stopOnFirstError,
  }) {
    return FormState(
      fields: fields ?? _fields,
      stopOnFirstError: stopOnFirstError ?? this.stopOnFirstError,
    );
  }
}
