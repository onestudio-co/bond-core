import 'package:one_studio_core/src/form/validation/validation_rule.dart';
import 'package:one_studio_core/src/form/form_fields/form_field_state.dart';

class Size extends ValidationRule<String> {
  final int size;
  Size(this.size) : super('Must be exactly $size characters');

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return value.length == size;
  }
}
