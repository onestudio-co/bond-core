import 'package:bond_form/src/form_fields/form_field_state.dart';
import 'package:bond_form/src/validation/validation_rule.dart';

/// A validation rule that checks if a boolean value is true.
///
/// This rule validates that the input boolean value is true.
class IsTrue<T> extends ValidationRule<T> {
  /// Creates a new instance of the [IsTrue] validation rule.
  ///
  /// - [message] A custom validation message (optional) to be displayed
  ///   when the validation fails.
  IsTrue({String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.isTrueValidationMessage(fieldName);

  @override
  bool validate(T value, Map<String, FormFieldState> fields) {
    if (value == null) {
      return false;
    }
    if (value is bool) {
      return value == true;
    }
    if (value is String) {
      return value.toLowerCase() == 'true';
    }

    if (value is num) {
      return value == 1;
    }

    throw ArgumentError(
      'Unsupported value type: ${value.runtimeType}, expected bool, String or num.',
    );
  }
}
