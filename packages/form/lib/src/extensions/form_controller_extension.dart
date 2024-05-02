import 'package:bond_form/bond_form.dart';

/// Extension methods for [FormController] for more type-safe updates.
extension XFormController on FormController {
  /// Updates a [TextFieldState] with a given [value].
  ///
  /// - [fieldName] The name of the text field to update.
  /// - [value] The new value for the text field.
  void updateText(String fieldName, String? value) {
    update<TextFieldState, String?>(fieldName, value);
  }

  /// Updates a [CheckboxFieldState] with a given [value].
  ///
  /// - [fieldName] The name of the checkbox field to update.
  /// - [value] The new value for the checkbox field.
  void updateCheckbox(String fieldName, bool? value) {
    update<CheckboxFieldState<bool>, bool?>(fieldName, value);
  }

  /// Updates a [CheckboxGroupFieldState] with a given [value].
  ///
  /// - [fieldName] The name of the checkbox group field to update.
  /// - [value] The new value for the checkbox group field.
  /// throws [ArgumentError] if the generic type T is not specified.
  void updateCheckboxGroup<T>(String fieldName, Set<T>? value) {
    if (T == Object) {
      throw ArgumentError(
          'The generic type T must be specified for updateCheckboxGroup<T>.');
    }
    update<CheckboxGroupFieldState<T>, Set<T>?>(fieldName, value);
  }

  /// Toggles the value of a specific checkbox within a checkbox group.
  ///
  /// Updates the set of selected values for the checkbox group field specified
  /// by [fieldName] to either include or exclude the given [value] based on
  /// the [selected] parameter.
  ///
  /// [fieldName] The name of the field associated with the checkbox group.
  /// [value] The value of the specific checkbox to toggle.
  /// [selected] A boolean indicating whether the checkbox is selected (`true`) or not (`false`).
  /// If `null`, the checkbox will be treated as not selected.
  ///
  /// This method automatically updates the state of the checkbox group field.
  void toggleCheckbox<T>(String fieldName, {T? value, bool? selected}) {
    final currentValues = state.checkboxValues<T>(fieldName);
    if (value == null) {
      return;
    }
    if (selected ?? false) {
      currentValues.add(value);
    } else {
      currentValues.remove(value);
    }
    updateCheckboxGroup<T>(fieldName, currentValues);
  }

  /// Updates a [DateFieldState] with a given [value].
  ///
  /// - [fieldName] The name of the date field to update.
  /// - [value] The new value for the date field.
  void updateDate(String fieldName, DateTime? value) {
    update<DateFieldState, DateTime?>(fieldName, value);
  }

  /// Updates a [DropDownFieldState] with a given [value].
  ///
  /// - [fieldName] The name of the dropdown field to update.
  /// - [value] The new value for the dropdown field.
  void updateDropDown<T>(String fieldName, T value) {
    update<DropDownFieldState<T>, T>(fieldName, value);
  }

  /// Updates a [AsyncDropDownFieldState] with a given [value].
  ///
  /// - [fieldName] The name of the async dropdown field to update.
  /// - [value] The new value for the dropdown field.
  void updateAsyncDropDown<T>(String fieldName, T value) {
    update<AsyncDropDownFieldState<T>, T>(fieldName, value);
  }

  /// Updates a [RadioButtonFieldState] with a given [value].
  ///
  /// - [fieldName] The name of the radio button field to update.
  /// - [value] The new value for the radio button field.
  void updateRadioButton<T>(String fieldName, T value) {
    update<RadioButtonFieldState<T>, T>(fieldName, value);
  }

  /// Updates a [RadioGroupFieldState] with a given [value].
  ///
  /// - [fieldName] The name of the radio group field to update.
  /// - [value] The new value for the radio group field.
  void updateRadioGroup<T>(String fieldName, T? value) {
    update<RadioGroupFieldState<T>, T?>(fieldName, value);
  }
}
