import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

/// A validation rule that checks if a phone number is valid.
///
/// This rule uses a regular expression to validate the format of the phone number.
class PhoneNumber extends ValidationRule<String> {
  /// Creates a new instance of the [PhoneNumberRule] validation rule.
  ///
  /// - [message]: A custom validation message (optional) to be displayed
  ///   when the validation fails.
  PhoneNumber({String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) {
    return l10n.phoneNumberValidationMessage(fieldName);
  }

  @override
  bool validate(String? value, Map<String, FormFieldState> fields) {
    if (value == null || value.isEmpty) {
      return true; // empty validation should be handled by a required rule
    }
    // A basic pattern for phone numbers. This will work for several formats, but it might be
    // necessary to adjust it according to the specific requirements or local standards.
    final pattern =
        r'^(?:\+?\d{1,3}?[-.\s]?)?(?:\(\d{1,3}\)?[-.\s]?)?\d{1,3}[-.\s]?\d{1,4}[-.\s]?\d{1,4}$';
    final regex = RegExp(pattern);

    return regex.hasMatch(value);
  }
}
