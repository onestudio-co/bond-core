import 'package:bond_form/src/form_fields/form_field_state.dart';
import 'package:bond_form/src/validation/validation_rule.dart';

/// A validation rule that checks if a value is required (not empty or null).
///
/// This rule validates that the input value is not empty or null.
class Required<T> extends ValidationRule<T> {
  /// Creates a new instance of the [Required] validation rule.
  ///
  /// - [message]: A custom validation message (optional) to be displayed
  ///   when the validation fails.
  Required({String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.requiredValidationMessage(fieldName);

  @override
  bool validate(T value, Map<String, FormFieldState> fields) {
    if (value is String) {
      return value.isNotEmpty;
    }
    if (value is List) {
      return value.isNotEmpty;
    }
    return value != null;
  }
}
