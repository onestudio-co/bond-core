import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';
import 'package:intl/intl.dart';

class DateBefore extends ValidationRule<DateTime> {
  final DateTime date;

  DateBefore(this.date, {String? message}) : super(message);

  DateBefore.fromString(String dateStr,
      {String? format = 'yyyy-MM-dd', String? message})
      : date = DateFormat(format).parse(dateStr),
        super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.dateBeforeValidationMessage(fieldName, date.toIso8601String());

  @override
  bool validate(DateTime value, Map<String, FormFieldState> fields) {
    return value.isBefore(date);
  }
}
