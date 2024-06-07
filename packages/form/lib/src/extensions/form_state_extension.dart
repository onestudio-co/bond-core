import 'package:bond_form/bond_form.dart';

import 'required_values.dart';

/// Extension methods for [BondFormState] providing convenience operations.
///
/// The `XBondFormState` extension adds methods to `BondFormState` to simplify
/// retrieving values from form fields. It also includes a method to ensure
/// required field values are not null.
///
/// Example usage:
/// ```dart
/// // Retrieve a potentially null value from a text field.
/// final phoneNumber = state.textFieldValue('phoneNumber');
///
/// // Retrieve a non-null value from a required text field.
/// final requiredPhoneNumber = state.required().textFieldValue('phoneNumber');
/// ```
///
/// Methods:
/// - [textField]: Retrieves the state of a text field.
/// - [textFieldValue]: Retrieves the value of a text field.
/// - [radioGroup]: Retrieves the state of a radio group field.
/// - [radioButtonsOf]: Retrieves a list of radio button states.
/// - [radioGroupValue]: Retrieves the value of a radio group field.
/// - [checkbox]: Retrieves the state of a checkbox field.
/// - [checkboxValue]: Retrieves the value of a checkbox field.
/// - [checkboxGroup]: Retrieves the state of a checkbox group field.
/// - [checkboxesOf]: Retrieves a list of checkbox states.
/// - [checkboxGroupValue]: Retrieves the first selected value of a checkbox group.
/// - [checkboxSelected]: Checks if a specific value is selected within a checkbox group.
/// - [dropDownField]: Retrieves the state of a dropdown field.
/// - [dropDownItems]: Retrieves a list of dropdown items.
/// - [dropDownValue]: Retrieves the value of a dropdown field.
/// - [asyncDropDownField]: Retrieves the state of an async dropdown field.
/// - [asyncDropDownItems]: Retrieves a list of async dropdown items.
/// - [asyncDropDownValue]: Retrieves the value of an async dropdown field.
/// - [required]: Returns an instance of `RequiredValues` to ensure required field values are not null.
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
  /// - Parameter [fieldName] The name of the text field to fetch.
  /// - Returns: The current value of the text field as a `String`, or `null` if not set.
  /// - Throws: [ArgumentError] if the field doesn't exist.
  String? textFieldValue(String fieldName) {
    return textField(fieldName).value;
  }

  /// Retrieves the state of the radio group field for a specified [fieldName].
  ///
  /// This method retrieves the state of the radio group field identified by the provided [fieldName].
  ///
  /// - Parameter [fieldName] The name of the radio group field to retrieve the state from.
  /// - Returns: The state of the radio group field.
  /// - Throws: [ArgumentError] if the field doesn't exist.
  RadioGroupFieldState<T> radioGroup<T>(String fieldName) {
    return get<RadioGroupFieldState<T>, T?>(fieldName);
  }

  /// Retrieves a list of [RadioButtonFieldState] for a specified [fieldName].
  ///
  /// This method simplifies fetching radio button states for the given [fieldName].
  ///
  /// - Parameter [fieldName] The name of the field to fetch.
  /// - Returns: A list of [RadioButtonFieldState] instances.
  /// - Throws: [ArgumentError] if the field doesn't exist.
  List<RadioButtonFieldState<T>> radioButtonsOf<T>(String fieldName) {
    return radioGroup<T>(fieldName).radioButtons;
  }

  /// Retrieves the value of a `RadioGroupFieldState` for a specified [fieldName].
  ///
  /// This method simplifies fetching the current value of a radio button group.
  ///
  /// - Parameter [fieldName] The name of the field to fetch.
  /// - Returns: The current value of the field or `null` if not set.
  /// - Throws: [ArgumentError] if the field doesn't exist.
  T? radioGroupValue<T>(String fieldName) {
    return radioGroup<T>(fieldName).value;
  }

  /// Retrieves the state of the checkbox field for a specified [fieldName].
  ///
  /// This method retrieves the state of the checkbox field identified by the provided [fieldName].
  ///
  /// - Parameter [fieldName] The name of the checkbox field to retrieve the state from.
  /// - Returns: The state of the checkbox field.
  /// - Throws: [ArgumentError] if the field doesn't exist.
  CheckboxFieldState<bool> checkbox(String fieldName) {
    return get<CheckboxFieldState<bool>, bool?>(fieldName);
  }

  /// Retrieves the value of a checkbox field for a specified [fieldName].
  ///
  /// This method simplifies fetching the current value of a checkbox.
  ///
  /// - Parameter [fieldName] The name of the field to fetch.
  /// - Returns: The current value of the field or `null` if not set.
  /// - Throws: [ArgumentError] if the field doesn't exist.
  bool checkboxValue<T>(String fieldName) {
    return checkbox(fieldName).value ?? false;
  }

  /// Retrieves the state of the checkbox group field for a specified [fieldName].
  ///
  /// This method retrieves the state of the checkbox group field identified by the provided [fieldName].
  ///
  /// - Parameter [fieldName] The name of the checkbox group field to retrieve the state from.
  /// - Returns: The state of the checkbox group field.
  /// - Throws: [ArgumentError] if the field doesn't exist.
  CheckboxGroupFieldState<T> checkboxGroup<T>(String fieldName) {
    return get<CheckboxGroupFieldState<T>, Set<T>>(fieldName);
  }

  /// Retrieves a list of [CheckboxFieldState] for a specified [fieldName].
  ///
  /// This method simplifies fetching checkbox states for the given [fieldName].
  ///
  /// - Parameter [fieldName] The name of the field to fetch.
  /// - Returns: A list of [CheckboxFieldState] instances.
  /// - Throws: [ArgumentError] if the field doesn't exist.
  List<CheckboxFieldState<T>> checkboxesOf<T>(String fieldName) {
    return checkboxGroup<T>(fieldName).checkboxes;
  }

  /// Retrieves the selected values of a checkbox group for a specified [fieldName].
  ///
  /// This method simplifies fetching selected checkbox values.
  ///
  /// - Parameter [fieldName] The name of the field to fetch.
  /// - Returns: A set containing the selected values.
  /// - Throws: [ArgumentError] if the field doesn't exist.
  Set<T> checkboxValues<T>(String fieldName) {
    return checkboxGroup<T>(fieldName).value;
  }

  /// Retrieves the first selected value of a checkbox group for a specified [fieldName].
  ///
  /// This method simplifies fetching the first selected checkbox value.
  ///
  /// - Parameter [fieldName] The name of the field to fetch.
  /// - Returns: The first selected value or `null` if none are selected.
  /// - Throws: [ArgumentError] if the field doesn't exist.
  T? checkboxGroupValue<T>(String fieldName) {
    return checkboxValues<T>(fieldName).firstOrNull;
  }

  /// Checks if a specific value is selected within a checkbox group.
  ///
  /// This method checks if a specific checkbox value is selected.
  ///
  /// - Parameter [fieldName] The name of the checkbox group.
  /// - Parameter [value] The specific value to check for.
  /// - Returns: `true` if the checkbox with the given value is selected, otherwise `false`.
  /// - Throws: [ArgumentError] if the field doesn't exist.
  bool checkboxSelected<T>(String fieldName, T value) {
    return checkboxValues<T>(fieldName).contains(value);
  }

  /// Retrieves the state of the dropdown field for a specified [fieldName].
  ///
  /// This method retrieves the state of the dropdown field identified by the provided [fieldName].
  ///
  /// - Parameter [fieldName] The name of the dropdown field to retrieve the state from.
  /// - Returns: The state of the dropdown field.
  /// - Throws: [ArgumentError] if the field doesn't exist.
  DropDownFieldState<T> dropDownField<T>(String fieldName) {
    return get<DropDownFieldState<T>, T>(fieldName);
  }

  /// Retrieves the list of dropdown items for a specified [fieldName].
  ///
  /// This method retrieves the list of dropdown items associated with the
  /// dropdown field identified by the provided [fieldName].
  ///
  /// - Parameter [fieldName] The name of the dropdown field to retrieve items from.
  /// - Returns: A list of [DropDownItemState] representing the items of the dropdown field.
  /// - Throws: [ArgumentError] if the field doesn't exist.
  List<DropDownItemState<T>> dropDownItems<T>(String fieldName) {
    return dropDownField<T>(fieldName).items;
  }

  /// Retrieves the selected value of the dropdown field for a specified [fieldName].
  ///
  /// This method retrieves the currently selected value of the dropdown field
  /// identified by the provided [fieldName].
  ///
  /// - Parameter [fieldName] The name of the dropdown field to retrieve the value from.
  /// - Returns: The selected value of the dropdown field, or `null` if no value is selected.
  /// - Throws: [ArgumentError] if the field doesn't exist.
  T? dropDownValue<T>(String fieldName) {
    return dropDownField<T>(fieldName).value;
  }

  /// Retrieves the state of the async dropdown field for a specified [fieldName].
  ///
  /// This method retrieves the state of the async dropdown field identified by the provided [fieldName].
  ///
  /// - Parameter [fieldName] The name of the async dropdown field to retrieve the state from.
  /// - Returns: The state of the async dropdown field.
  /// - Throws: [ArgumentError] if the field doesn't exist.
  AsyncDropDownFieldState<T> asyncDropDownField<T>(String fieldName) {
    return get<AsyncDropDownFieldState<T>, T>(fieldName);
  }

  /// Retrieves the list of dropdown items for a specified [fieldName].
  ///
  /// This method retrieves the list of async dropdown items associated with the
  /// async dropdown field identified by the provided [fieldName].
  ///
  /// - Parameter [fieldName] The name of the async dropdown field to retrieve items from.
  /// - Returns: A list of [DropDownItemState] representing the items of the async dropdown field.
  /// - Throws: [ArgumentError] if the field doesn't exist.
  Future<List<DropDownItemState<T>>> asyncDropDownItems<T>(String fieldName) {
    return asyncDropDownField<T>(fieldName).items;
  }

  /// Retrieves the selected value of the async dropdown field for a specified [fieldName].
  ///
  /// This method retrieves the currently selected value of the async dropdown field
  /// identified by the provided [fieldName].
  ///
  /// - Parameter [fieldName] The name of the async dropdown field to retrieve the value from.
  /// - Returns: The selected value of the async dropdown field, or `null` if no value is selected.
  /// - Throws: [ArgumentError] if the field doesn't exist.
  T? asyncDropDownValue<T>(String fieldName) {
    return asyncDropDownField<T>(fieldName).value;
  }

  /// Retrieves the [RequiredValues] extension for the current form state.
  RequiredValues required() => RequiredValues(this);
}
