import 'dart:io';

import 'package:bond_form/bond_form.dart';

import 'required_values.dart';

/// Extension methods for [BondFormState] providing convenience operations.
///
/// The `ValueBondFormState` extension adds methods to `BondFormState` to simplify
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
/// - [textFieldValue] Retrieves the value of a text field.
/// - [radioGroupValue] Retrieves the value of a radio group field.
/// - [asyncRadioGroupValue] Retrieves the value of an async radio group field.
/// - [checkboxSelected] Checks if a specific value is selected within a checkbox group.
/// - [checkboxValues] Retrieves the selected values of a checkbox group.
/// - [checkboxValue] Retrieves the value of a checkbox field.
/// - [checkboxGroupValue] Retrieves the first selected value of a checkbox group.
/// - [dateFieldValue] Retrieves the value of a date field.
/// - [dropDownValue] Retrieves the value of a dropdown field.
/// - [asyncDropDownValue] Retrieves the value of an async dropdown field.
/// - [hiddenFieldValue] Retrieves the value of a hidden field.
/// - [fileFieldValue] Retrieves the value of a file field.
/// - [required] Retrieves the [RequiredValues] extension for the current form state.
extension ValueBondFormState on BaseBondFormState {
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

  /// Retrieves the value of a `RadioGroupFieldState` for a specified [fieldName].
  ///
  /// This method simplifies fetching the current value of a radio button group.
  ///
  /// - Parameter [fieldName] The name of the field to fetch.
  /// - Returns: The current value of the field or `null` if not set.
  /// - Throws: [ArgumentError] if the field doesn't exist.
  T radioGroupValue<T>(String fieldName) {
    return radioGroup<T>(fieldName).value;
  }

  /// Retrieves the value of an `AsyncRadioGroupFieldState` for a specified [fieldName].
  ///
  /// This method simplifies fetching the current value of an async radio button group.
  ///
  /// - Parameter [fieldName] The name of the field to fetch.
  /// - Returns: The current value of the field or `null` if not set.
  /// - Throws: [ArgumentError] if the field doesn't exist.
  T asyncRadioGroupValue<T>(String fieldName) {
    return asyncRadioGroup<T>(fieldName).value;
  }

  /// Retrieves the value of a checkbox field for a specified [fieldName].
  ///
  /// This method simplifies fetching the current value of a checkbox.
  ///
  /// - Parameter [fieldName] The name of the field to fetch.
  /// - Returns: The current value of the field.
  /// - Throws: [ArgumentError] if the field doesn't exist.
  bool checkboxValue<T>(String fieldName) {
    return checkbox(fieldName).value;
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

  /// Retrieves the value of a date field for a specified [fieldName].
  ///
  /// This method simplifies fetching the current value of a date field.
  ///
  /// - Parameter [fieldName] The name of the date field to fetch.
  /// - Returns: The current value of the date field as a `DateTime`, or `null` if not set.
  /// - Throws: [ArgumentError] if the field doesn't exist.
  DateTime? dateFieldValue(String fieldName) {
    return dateField(fieldName).value;
  }

  /// Retrieves the selected value of the dropdown field for a specified [fieldName].
  ///
  /// This method retrieves the currently selected value of the dropdown field
  /// identified by the provided [fieldName].
  ///
  /// - Parameter [fieldName] The name of the dropdown field to retrieve the value from.
  /// - Returns: The selected value of the dropdown field, or `null` if no value is selected.
  /// - Throws: [ArgumentError] if the field doesn't exist.
  T dropDownValue<T>(String fieldName) {
    return dropDownField<T>(fieldName).value;
  }

  /// Retrieves the selected value of the async dropdown field for a specified [fieldName].
  ///
  /// This method retrieves the currently selected value of the async dropdown field
  /// identified by the provided [fieldName].
  ///
  /// - Parameter [fieldName] The name of the async dropdown field to retrieve the value from.
  /// - Returns: The selected value of the async dropdown field, or `null` if no value is selected.
  /// - Throws: [ArgumentError] if the field doesn't exist.
  T asyncDropDownValue<T>(String fieldName) {
    return asyncDropDownField<T>(fieldName).value;
  }

  /// Retrieves the value of a hidden field for a specified [fieldName].
  ///
  /// This method simplifies fetching the current value of a hidden field.
  ///
  /// - Parameter [fieldName] The name of the hidden field to fetch.
  /// - Returns: The current value of the hidden field as a `T`, or `null` if not set.
  /// - Throws: [ArgumentError] if the field doesn't exist.
  T hiddenFieldValue<T>(String fieldName) {
    return hiddenField<T>(fieldName).value;
  }

  /// Retrieves the value of a file field for a specified [fieldName].
  ///
  /// This method simplifies fetching the current value of a file field.
  ///
  /// - Parameter [fieldName] The name of the file field to fetch.
  /// - Returns: The current value of the file field as a `File`, or `null` if not set.
  /// - Throws: [ArgumentError] if the field doesn't exist.
  File? fileFieldValue(String fieldName) {
    return fileField(fieldName).value;
  }

  /// Retrieves the [RequiredValues] extension for the current form state.
  RequiredValues required() => RequiredValues(this);
}
