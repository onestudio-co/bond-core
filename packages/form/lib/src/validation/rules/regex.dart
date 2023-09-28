import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

/// A validation rule that checks if a string matches a specified regular expression.
///
/// This rule validates that the input string matches the specified regular expression.
class Regex extends ValidationRule<String> {
  /// The regular expression pattern to match against.
  final RegExp regex;

  /// Creates a new instance of the [Regex] validation rule.
  ///
  /// - [regex]: The regular expression pattern to match against (required).
  /// - [message]: A custom validation message (optional) to be displayed
  ///   when the validation fails.
  Regex(this.regex, {String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.regexValidationMessage(fieldName);

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return regex.hasMatch(value);
  }
}
