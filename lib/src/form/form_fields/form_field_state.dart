import 'package:meta/meta.dart';
import 'package:one_studio_core/src/form/validation/validation_rule.dart';

abstract class FormFieldState<T> {
  T value;
  String? error;
  String label;
  List<ValidationRule<T>> rules;

  FormFieldState({
    required this.value,
    this.error,
    required this.label,
    this.rules = const [],
  });

  void update(T newValue);

  @nonVirtual
  String? validate(Map<String, FormFieldState> fields) {
    for (var rule in rules) {
      if (!rule.validate(value, fields)) {
        return rule.message;
      }
    }
    return null;
  }
}

