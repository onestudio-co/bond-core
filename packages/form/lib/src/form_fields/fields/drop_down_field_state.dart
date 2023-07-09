import 'package:bond_form/src/form_fields.dart';
import 'package:bond_form/src/validation/rules.dart';

class DropDownFieldState<T> extends FormFieldState<T> {
  final List<DropDownItemState<T>> items;

  DropDownFieldState(
    T value, {
    required this.items,
    required String label,
    List<ValidationRule<T>> rules = const [],
  }) : super(value: value, label: label, rules: rules);
}