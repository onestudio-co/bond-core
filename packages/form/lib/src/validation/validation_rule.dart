import 'package:bond_core/bond_core.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';
import 'package:bond_form/validator_localizations.dart';

/// Represents a validation rule that can be applied to a form field.
///
/// This abstract class defines the structure for creating custom validation
/// rules for form fields.
abstract class ValidationRule<T> {
  /// Creates a new instance of [ValidationRule].
  ///
  /// - [_message]: A custom validation message provided by the user (optional).
  ValidationRule(this._message);

  /// The [ValidatorLocalizations] instance used for localization of validation messages.
  /// It's obtained through a service locator (`sl`) for convenience.
  ValidatorLocalizations get l10n => sl<ValidatorLocalizations>();

  final String? _message;

  /// Retrieves the validator message for the field.
  ///
  /// - [fieldName]: The name or label of the form field being validated.
  ///
  /// Subclasses should implement this method to provide specific validation messages.
  String validatorMessage(String fieldName);

  /// Retrieves the validation message to be displayed.
  ///
  /// - [fieldName]: The name or label of the form field being validated.
  ///
  /// Returns the custom validation message if provided by the user, otherwise,
  /// it falls back to the validator message defined by the subclass.
  String message(String fieldName) => _message ?? validatorMessage(fieldName);

  /// Validates the given [value] against the validation rule.
  ///
  /// - [value]: The value to be validated.
  /// - [fields]: A map of form field states for cross-field validation.
  ///
  /// Returns `true` if the validation passes, `false` otherwise.
  bool validate(T value, Map<String, FormFieldState> fields);
}
