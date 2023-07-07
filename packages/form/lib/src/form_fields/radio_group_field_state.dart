import '../../bond_form.dart';

class RadioGroupFieldState<T> extends FormFieldState<T?> {
  final List<RadioButtonFieldState<T>> radioButtons;

  RadioGroupFieldState(
    this.radioButtons, {
    required String label,
    T? value,
    bool required = false,
    String? errorMessage,
  }) : super(
          value: value,
          label: label,
          rules: [
            required
                ? RadioGroupRequiredRule<T>(message: errorMessage)
                : _EmptyRule<T>(),
          ],
        );
}

class _EmptyRule<T> extends ValidationRule<T> {
  _EmptyRule() : super(null);

  @override
  bool validate(T value, Map<String, FormFieldState<dynamic>> fields) => true;

  @override
  String validatorMessage(String fieldName) => '';
}

class RadioGroupRequiredRule<T> extends ValidationRule<T> {
  RadioGroupRequiredRule({String? message}) : super(message);

  @override
  bool validate(T? value, Map<String, FormFieldState<dynamic>> fields) =>
      value != null;

  @override
  String validatorMessage(String fieldName) =>
      l10n.requiredValidationMessage(fieldName);
}
