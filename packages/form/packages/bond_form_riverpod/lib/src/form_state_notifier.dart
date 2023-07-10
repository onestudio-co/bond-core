import 'dart:developer';

import 'package:bond_form/bond_form.dart';
import 'package:riverpod/riverpod.dart';

abstract class FormStateNotifier extends Notifier<BondFormState> {
  final Map<String, FormFieldState> _fields;
  final bool _stopOnFirstError;

  FormStateNotifier({
    required Map<String, FormFieldState> fields,
    bool stopOnFirstError = false,
  })  : _stopOnFirstError = stopOnFirstError,
        _fields = fields;

  @override
  BondFormState build() => BondFormState(
        fields: _fields,
        stopOnFirstError: _stopOnFirstError,
      );

  FormFieldState<T> get<T>(String fieldName) {
    if (!_fields.containsKey(fieldName)) {
      throw ArgumentError('No field found with name $fieldName');
    }
    return _fields[fieldName] as FormFieldState<T>;
  }

  FormFieldState operator [](String fieldName) => get(fieldName);

  String label<T>(String fieldName) => get<T>(fieldName).label;

  String? error<T>(String fieldName) => get<T>(fieldName).error;

  void update<T>(String fieldName, T value) {
    var field = get<T>(fieldName);
    field.value = value;
    field.touched =
        true; // The field is being interacted with, so update `touched`
    if (field.validateOnUpdate && field.touched) {
      field.error = field.validate(_fields);
    }
    _fields[fieldName] = field;
    state = state.copyWith(fields: Map.from(_fields));
  }

  bool get _allValid {
    var allValid = true;
    for (final fieldName in _fields.keys) {
      final field = get(fieldName);
      final error = field.validate(_fields);
      if (error != null) {
        allValid = false;
        field.error = error; // Set the error of the field
        if (state.stopOnFirstError) {
          break;
        }
      }
    }
    return allValid;
  }

  Future<void> submit() => _onSubmit();

  Future<void> onSubmit();

  Future<void> _onSubmit() {
    if (_allValid) {
      return onSubmit();
    }
    log('Form is not on valid state ${_fields.values.map((e) => e.error).join('\n')}');
    return Future.value();
  }
}
