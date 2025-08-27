import 'package:bond_form/src/form_fields/form_field_state.dart';
import 'package:bond_form/src/validation/validation_rule.dart';

/// A validation rule that marks a field as optional.
///
/// If the value is not present (null, empty string, or empty list),
/// the validation passes and skips all other rules.
/// If the value is present, other rules will be validated against the value.
class Optional<T> extends ValidationRule<T> {
  /// Creates a new instance of the [Optional] validation rule.
  Optional({String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) => '';

  @override
  bool validate(T value, Map<String, FormFieldState> fields) {
    // If the value is null, an empty string, or an empty list, skip validation
    if (value == null ||
        (value is String && value.isEmpty) ||
        (value is Iterable && value.isEmpty)) {
      return true;
    }

    // If the value is present, we proceed to validate with other rules
    return false; // Returning false indicates that other rules should now validate this field
  }
}
