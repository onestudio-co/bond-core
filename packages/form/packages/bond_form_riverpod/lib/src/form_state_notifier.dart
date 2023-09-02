import 'dart:developer';

import 'package:bond_form/bond_form.dart';
import 'package:riverpod/riverpod.dart';

abstract class FormStateNotifier<Success, Failure extends Error>
    extends Notifier<BondFormState<Success, Failure>> {
  final bool stopOnFirstError;

  FormStateNotifier({
    required Map<String, FormFieldState> fields,
    this.stopOnFirstError = false,
  }) {
    // state = BondFormState<Success, Failure>(fields: fields);
  }

  @override
  BondFormState<Success, Failure> build() =>
      BondFormState<Success, Failure>(fields: state.fields);

  FormFieldState<T> get<T>(String fieldName) {
    if (!state.fields.containsKey(fieldName)) {
      throw ArgumentError('No field found with name $fieldName');
    }
    return state.fields[fieldName] as FormFieldState<T>;
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
      field.error = field.validate(state.fields);
    }
    state.fields[fieldName] = field;
    state = state.copyWith(fields: Map.from(state.fields));
  }

  bool get _allValid {
    var allValid = true;
    for (final fieldName in state.fields.keys) {
      final field = get(fieldName);
      final error = field.validate(state.fields);
      if (error != null) {
        allValid = false;
        field.error = error; // Set the error of the field
        if (stopOnFirstError) {
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
    log('Form is not on valid state ${state.fields.values.map((e) => e.error).join('\n')}');
    return Future.value();
  }
}
