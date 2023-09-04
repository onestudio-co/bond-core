import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

/// A validation rule that checks if a value is the same as the value of another field.
///
/// This rule validates that the input value is the same as the value of another field.
class Same<T> extends ValidationRule<T> {
  /// The name of the other field to compare values against.
  final String otherField;

  /// Creates a new instance of the [Same] validation rule.
  ///
  /// - [otherField]: The name of the other field to compare values against (required).
  /// - [message]: A custom validation message (optional) to be displayed
  ///   when the validation fails.
  Same(this.otherField, {String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.sameValidationMessage(fieldName, otherField);

  @override
  bool validate(T value, Map<String, FormFieldState> fields) {
    if (!fields.containsKey(otherField)) {
      throw ArgumentError('Field $otherField does not exist');
    }
    return value == fields[otherField]!.value;
  }
}
