import 'dart:developer';

import 'package:bond_form/bond_form.dart';
import 'package:riverpod/riverpod.dart';

abstract class FormStateNotifier<Success, Failure extends Error>
    extends Notifier<BondFormState<Success, Failure>> {
  final bool stopOnFirstError;

  Map<String, FormFieldState> fields();

  FormStateNotifier({
    this.stopOnFirstError = false,
  });

  @override
  BondFormState<Success, Failure> build() =>
      BondFormState<Success, Failure>(fields: fields());

  void update<T>(String fieldName, T value) {
    var field = state.get<T?>(fieldName);
    field.value = value;
    field.touched = true; // The field is being interacted with, so update `touched`
    state.fields[fieldName] = field;
    final status = _allValid ? BondFormStateStatus.valid : BondFormStateStatus.invalid;
    state = state.copyWith(
      fields: Map.from(state.fields),
      status: status,
    );
  }

  bool get _allValid {
    var allValid = true;
    for (final fieldName in state.fields.keys) {
      final field = state.get(fieldName);
      final error = field.validate(state.fields);
      if (error != null) {
        allValid = false;
        if (field.validateOnUpdate && field.touched) {
          field.error = field.validate(state.fields);
        }
        if (stopOnFirstError) {
          break;
        }
      } else {
        field.error = null;
      }
    }
    return allValid;
  }

  Future<void> submit() => _onSubmit();

  Future<Success> onSubmit();

  Future<void> _onSubmit() async {
    if (_allValid) {
      state = state.copyWith(
        fields: Map.from(state.fields),
        status: BondFormStateStatus.submitting,
      );
      try {
        final result = await onSubmit();
        state = state.copyWith(
          status: BondFormStateStatus.submitted,
          success: result,
        );
      } catch (e) {
        state = state.copyWith(
          status: BondFormStateStatus.failed,
          failure: e as Failure,
        );
      }
    } else {
      state = state.copyWith(
        fields: Map.from(state.fields),
        status: BondFormStateStatus.invalid,
      );
      final errors = state.fields.values
          .where((element) => element.error != null)
          .map((e) => '*${e.error}*')
          .join('\n');
      log('Form is not on valid state\n$errors');
    }
  }
}
