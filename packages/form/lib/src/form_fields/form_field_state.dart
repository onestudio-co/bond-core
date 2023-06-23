import 'package:meta/meta.dart' show nonVirtual;
import 'package:bond_form/form.dart';

abstract class FormFieldState<T> {
  T value;
  String? error;
  String label;
  List<ValidationRule<T>> rules;
  bool validateOnUpdate;
  bool touched;

  FormFieldState({
    required this.value,
    this.error,
    required this.label,
    this.touched = false,
    this.validateOnUpdate = true,
    this.rules = const [],
  });

  @nonVirtual
  String? validate(Map<String, FormFieldState> fields) {
    for (var rule in rules) {
      if (!rule.validate(value, fields)) {
        return rule.message(label);
      }
    }
    return null;
  }
}
