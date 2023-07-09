import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';
import 'package:intl/intl.dart';

class DateAfter extends ValidationRule<DateTime> {
  final DateTime date;

  DateAfter(this.date, {String? message}) : super(message);

  DateAfter.fromString(String date, {String? format, String? message})
      : date = DateFormat(format).parse(date),
        super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.dateAfterValidationMessage(fieldName, date.toIso8601String());

  @override
  bool validate(DateTime value, Map<String, FormFieldState> fields) {
    return value.isAfter(date);
  }
}
