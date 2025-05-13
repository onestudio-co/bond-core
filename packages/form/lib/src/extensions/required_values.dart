import 'dart:io';

import 'package:bond_form/bond_form.dart';

/// A utility class to ensure required form field values are not null.
///
/// The `RequiredValues` class provides methods to retrieve the values of
/// various form fields while ensuring that the values are not null. If a
/// field's value is null, an [ArgumentError] is thrown.
///
/// This class is used in conjunction with the `BondFormState` extension method
/// `required()`, which returns an instance of `RequiredValues`.
///
/// Example usage:
/// ```dart
/// final phoneNumber = state.required().textFieldValue('phoneNumber');
/// ```
///
/// The above example retrieves the value of the `phoneNumber` text field and
/// ensures that the value is not null.
///
/// Methods:
/// - [textFieldValue] Ensures the value of a text field is not null.
/// - [radioGroupValue] Ensures the value of a radio group field is not null.
/// - [asyncRadioGroupValue] Ensures the value of an async radio group field is not null.
/// - [checkboxGroupValue] Ensures the first selected value of a checkbox group is not null.
/// - [dateFieldValue] Ensures the value of a date field is not null.
/// - [dropDownValue] Ensures the value of a dropdown field is not null.
/// - [asyncDropDownValue] Ensures the value of an async dropdown field is not null.
/// - [hiddenFieldValue] Ensures the value of a hidden field is not null.
class RequiredValues {
  final BaseBondFormState state;

  RequiredValues(this.state);

  /// Ensures the value of a text field is not null.
  ///
  /// - Parameter [fieldName] The name of the text field to fetch.
  /// - Returns: The current value of the text field as a non-null `String`.
  /// - Throws: [ArgumentError] if the field doesn't exist or if the value is null.
  String textFieldValue(String fieldName) {
    final value = state.textFieldValue(fieldName);
    if (value == null) {
      throw ArgumentError('Field $fieldName is required but its value is null');
    }
    return value;
  }

  /// Ensures the value of a radio group field is not null.
  ///
  /// - Parameter [fieldName] The name of the field to fetch.
  /// - Returns: The current value of the field as a non-null `T`.
  /// - Throws: [ArgumentError] if the field doesn't exist or if the value is null.
  T radioGroupValue<T>(String fieldName) {
    final value = state.radioGroupValue<T>(fieldName);
    if (value == null) {
      throw ArgumentError('Field $fieldName is required but its value is null');
    }
    return value;
  }

  /// Ensures the value of an async radio group field is not null.
  ///
  // - Parameter [fieldName] The name of the field to fetch.
  /// - Returns: The current value of the field as a non-null `T`.
  /// - Throws: [ArgumentError] if the field doesn't exist or if the value is null.
  T asyncRadioGroupValue<T>(String fieldName) {
    final value = state.asyncRadioGroupValue<T>(fieldName);
    if (value == null) {
      throw ArgumentError('Field $fieldName is required but its value is null');
    }
    return value;
  }

  /// Ensures the first selected value of a checkbox group is not null.
  ///
  /// - Parameter [fieldName] The name of the field to fetch.
  /// - Returns: The first selected value as a non-null `T`.
  /// - Throws: [ArgumentError] if the field doesn't exist or if the value is null.
  T checkboxGroupValue<T>(String fieldName) {
    final value = state.checkboxGroupValue<T>(fieldName);
    if (value == null) {
      throw ArgumentError('Field $fieldName is required but its value is null');
    }
    return value;
  }

  /// Ensures the value of a date field is not null.
  ///
  /// - Parameter [fieldName] The name of the date field to fetch.
  /// - Returns: The current value of the date field as a non-null `DateTime`.
  /// - Throws: [ArgumentError] if the field doesn't exist or if the value is null.
  DateTime dateFieldValue(String fieldName) {
    final value = state.dateFieldValue(fieldName);
    if (value == null) {
      throw ArgumentError('Field $fieldName is required but its value is null');
    }
    return value;
  }

  /// Ensures the value of a dropdown field is not null.
  ///
  /// - Parameter [fieldName] The name of the dropdown field to fetch.
  /// - Returns: The current value of the dropdown field as a non-null `T`.
  /// - Throws: [ArgumentError] if the field doesn't exist or if the value is null.
  T dropDownValue<T>(String fieldName) {
    final value = state.dropDownValue<T>(fieldName);
    if (value == null) {
      throw ArgumentError('Field $fieldName is required but its value is null');
    }
    return value;
  }

  /// Ensures the value of an async dropdown field is not null.
  ///
  /// - Parameter [fieldName] The name of the async dropdown field to fetch.
  /// - Returns: The current value of the async dropdown field as a non-null `T`.
  /// - Throws: [ArgumentError] if the field doesn't exist or if the value is null.
  T asyncDropDownValue<T>(String fieldName) {
    final value = state.asyncDropDownValue<T>(fieldName);
    if (value == null) {
      throw ArgumentError('Field $fieldName is required but its value is null');
    }
    return value;
  }

  /// Ensures the value of a hidden field is not null.
  ///
  /// - Parameter [fieldName] The name of the hidden field to fetch.
  /// - Returns: The current value of the hidden field as a non-null `T`.
  /// - Throws: [ArgumentError] if the field doesn't exist or if the value is null.
  T hiddenFieldValue<T>(String fieldName) {
    final value = state.hiddenFieldValue<T>(fieldName);
    if (value == null) {
      throw ArgumentError('Field $fieldName is required but its value is null');
    }
    return value;
  }

  /// Ensures the value of a file field is not null.
  ///
  /// - Parameter [fieldName] The name of the file field to fetch.
  /// - Returns: The current value of the file field as a non-null `File`.
  /// - Throws: [ArgumentError] if the field doesn't exist or if the value is null.
  File fileFieldValue(String fieldName) {
    final value = state.fileFieldValue(fieldName);
    if (value == null) {
      throw ArgumentError('Field $fieldName is required but its value is null');
    }
    return value;
  }
}
