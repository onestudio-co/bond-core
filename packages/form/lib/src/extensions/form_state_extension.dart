import 'package:bond_form/bond_form.dart';

/// Extension methods for [BondFormState] providing convenience operations.
extension XBondFormState on BondFormState {
  /// Retrieves the [TextFieldState] for a given text field.
  ///
  /// This method simplifies fetching the state of a text field with a specified [fieldName].
  ///
  /// - Parameter [fieldName]: The name of the text field for which the state is to be fetched.
  /// - Returns: The [TextFieldState] corresponding to the given [fieldName].
  /// - Throws: [ArgumentError] if the field doesn't exist.
  TextFieldState textField(String fieldName) {
    return get<TextFieldState, String?>(fieldName);
  }

  /// Retrieves the value of a text field for a specified [fieldName].
  ///
  /// This method simplifies fetching the current value of a text field.
  ///
  /// - Parameter [fieldName]: The name of the text field to fetch.
  /// - Returns: The current value of the text field as a `String`, or `null` if not set.
  String? textFieldValue(String fieldName) {
    return get<TextFieldState, String?>(fieldName).value;
  }

  /// Retrieves a list of [RadioButtonFieldState] for a specified [fieldName].
  ///
  /// This method simplifies fetching radio button states for the given [fieldName].
  ///
  /// - Parameter [fieldName]: The name of the field to fetch.
  /// - Returns: A list of [RadioButtonFieldState] instances.
  /// - Throws: [ArgumentError] if the field doesn't exist.
  List<RadioButtonFieldState<T>> radioButtonsOf<T>(String fieldName) {
    return get<RadioGroupFieldState<T>, T?>(fieldName).radioButtons;
  }

  /// Retrieves the value of a `RadioGroupFieldState` for a specified [fieldName].
  ///
  /// This method simplifies fetching the current value of a radio button group.
  ///
  /// - Parameter [fieldName]: The name of the field to fetch.
  /// - Returns: The current value of the field or `null` if not set.
  T? radioGroupValue<T>(String fieldName) {
    return get<RadioGroupFieldState<T>, T?>(fieldName).value;
  }

  /// Retrieves a list of [CheckboxFieldState] for a specified [fieldName].
  ///
  /// This method simplifies fetching checkbox states for the given [fieldName].
  ///
  /// - Parameter [fieldName]: The name of the field to fetch.
  /// - Returns: A list of [CheckboxFieldState] instances.
  List<CheckboxFieldState<T>> checkboxesOf<T>(String fieldName) {
    return get<CheckboxGroupFieldState<T>, Set<T>?>(fieldName).checkboxes;
  }

  /// Retrieves the selected values of a checkbox group for a specified [fieldName].
  ///
  /// This method simplifies fetching selected checkbox values.
  ///
  /// - Parameter [fieldName]: The name of the field to fetch.
  /// - Returns: A set containing the selected values.
  Set<T> checkboxValues<T>(String fieldName) {
    return get<CheckboxGroupFieldState<T>, Set<T>>(fieldName).value;
  }

  /// Retrieves the first selected value of a checkbox group for a specified [fieldName].
  ///
  /// This method simplifies fetching the first selected checkbox value.
  ///
  /// - Parameter [fieldName]: The name of the field to fetch.
  /// - Returns: The first selected value or `null` if none are selected.
  T? checkboxValue<T>(String fieldName) {
    return checkboxValues<T>(fieldName).firstOrNull;
  }

  /// Checks if a specific value is selected within a checkbox group.
  ///
  /// This method checks if a specific checkbox value is selected.
  ///
  /// - Parameter [fieldName]: The name of the checkbox group.
  /// - Parameter [value]: The specific value to check for.
  /// - Returns: `true` if the checkbox with the given value is selected, otherwise `false`.
  bool checkboxSelected<T>(String fieldName, T value) {
    return checkboxValues<T>(fieldName).contains(value);
  }
}
