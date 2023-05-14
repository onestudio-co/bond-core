import 'package:one_studio_core/src/form/form_fields/form_field_state.dart';

abstract class ValidationRule<T> {
  String message;
  ValidationRule(this.message);
  bool validate(T value, Map<String, FormFieldState> fields);
}
