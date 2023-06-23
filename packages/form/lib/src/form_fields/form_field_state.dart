import 'package:meta/meta.dart' show nonVirtual;
import '../../bond_form.dart';

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
    for (final rule in rules) {
      if (!rule.validate(value, fields)) {
        return rule.message(label);
      }
    }
    return null;
  }
}
