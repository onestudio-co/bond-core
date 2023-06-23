import 'package:bond_core/core.dart';
import '../../form.dart';

abstract class ValidationRule<T> {
  ValidationRule(this._message);

  // validator localizations instance, no need to pass it to every rule
  ValidatorLocalizations get l10n => sl<ValidatorLocalizations>();

  final String? _message; // user custom validation message

  String validatorMessage(String fieldName); // form bond validator message

  // return user custom validation message or form bond validator message
  String message(String fieldName) => _message ?? validatorMessage(fieldName);

  bool validate(T value, Map<String, FormFieldState> fields);
}
