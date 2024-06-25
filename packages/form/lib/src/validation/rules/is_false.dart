import 'package:bond_form/src/form_fields/form_field_state.dart';
import 'package:bond_form/src/validation/validation_rule.dart';

/// A validation rule that checks if a boolean value is false.
///
/// This rule validates that the input boolean value is false.
class IsFalse<T> extends ValidationRule<T> {
  /// Creates a new instance of the [IsFalse] validation rule.
  ///
  /// - [message] A custom validation message (optional) to be displayed
  ///   when the validation fails.
  IsFalse({String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.isFalseValidationMessage(fieldName);

  @override
  bool validate(T value, Map<String, FormFieldState> fields) {
    if (value == null) {
      return false;
    }
    if (value is bool) {
      return value == false;
    }
    if (value is String) {
      return value.toLowerCase() == 'false';
    }

    if (value is num) {
      return value == 0;
    }

    throw ArgumentError(
      'Unsupported value type: ${value.runtimeType}, expected bool, String or num.',
    );
  }
}
