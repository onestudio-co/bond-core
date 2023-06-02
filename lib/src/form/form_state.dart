import 'package:riverpod/riverpod.dart';

import 'form_fields/form_field_state.dart';

class FormState {
  final Map<String, FormFieldState> _fields;

  FormState({
    required Map<String, FormFieldState> fields,
  }) : _fields = fields;

  FormState copyWith({
    Map<String, FormFieldState>? fields,
  }) {
    return FormState(
      fields: fields ?? _fields,
    );
  }
}

abstract class FormStateNotifier extends Notifier<FormState> {
  final Map<String, FormFieldState> _fields;

  FormStateNotifier({
    required Map<String, FormFieldState> fields,
  }) : _fields = fields;

  @override
  FormState build() => FormState(fields: _fields);

  FormFieldState<T> get<T>(String fieldName) {
    if (!_fields.containsKey(fieldName)) {
      throw ArgumentError('No field found with name $fieldName');
    }
    return _fields[fieldName] as FormFieldState<T>;
  }

  void update<T>(String fieldName, T value) {
    var field = get<T>(fieldName);
    field.update(value);
    state = state.copyWith(fields: Map.from(_fields));
  }

  String? validate<T>(String fieldName) {
    var field = get<T>(fieldName);
    var error = field.validate(_fields);
    field.error = error;
    _fields[fieldName] = field;
    return error;
  }

  bool validateAll() {
    bool allValid = true;
    for (final fieldName in _fields.keys) {
      final error = validate(fieldName);
      if (error != null) {
        allValid = false;
      }
    }
    return allValid;
  }

  Future<void> submit();
}
