import '../../form.dart';

class DateFieldState extends FormFieldState<DateTime?> {
  DateFieldState(
    DateTime? value, {
    required String label,
    List<ValidationRule<DateTime?>> rules = const [],
  }) : super(value: value, label: label, rules: rules);
}
