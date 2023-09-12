import 'package:bond_form/bond_form.dart';

/// Extension methods for [BondFormState].
///
/// These methods are designed to provide convenience operations on
/// [BondFormState] instances for managing and accessing form fields.
extension XBondFormState on BondFormState {
  /// Gets a list of [RadioButtonFieldState] for a specified field name.
  ///
  /// This method fetches the list of radio button states for the given
  /// [fieldName] by first retrieving the corresponding [RadioGroupFieldState].
  ///
  /// Example usage:
  /// ```dart
  /// final radioButtons = bondFormState.radioButtonsOf<String>('fieldName');
  /// ```
  ///
  /// - [fieldName]: The name of the field whose radio buttons we want to get.
  /// - Returns: A list of [RadioButtonFieldState] that belong to the field
  ///   specified by [fieldName].
  ///
  /// Throws:
  /// - [ArgumentError] if no field with [fieldName] exists.
  List<RadioButtonFieldState<T>> radioButtonsOf<T>(String fieldName) {
    return get<RadioGroupFieldState<T>, T?>(fieldName).radioButtons;
  }

  /// Retrieves the current group value of a `RadioGroupFieldState` associated with the given [fieldName].
  ///
  /// This method simplifies the process of getting the current value for a radio button group in a form.
  /// The generic type `T` refers to the type of the value that the radio button group holds.
  ///
  /// Example usage:
  /// ```dart
  /// final sizeValue = formState.radioGroupValue<String>('size');
  /// ```
  ///
  /// - [fieldName]: The name of the field corresponding to the radio button group.
  ///
  /// Returns:
  /// The current value of the radio button group, or `null` if not set.
  T? radioGroupValue<T>(String fieldName) {
    return get<RadioGroupFieldState<T>, T?>(fieldName).value;
  }

  /// Fetches the list of [CheckboxFieldState] objects associated with a given field name.
  ///
  /// This utility method simplifies the process of retrieving the checkbox states
  /// for a particular field within the form. The method is generic and works for checkboxes
  /// of any type `T`.
  ///
  /// [fieldName] is the name of the field whose checkbox states you want to retrieve.
  ///
  /// Returns a list of [CheckboxFieldState<T>] objects representing the state of each checkbox
  /// within the specified field.
  ///
  /// Example:
  /// ```dart
  /// final toppings = formState.checkboxesOf<PizzaTopping>('toppings');
  /// ```
  ///   /// Throws:
  /// - [ArgumentError] if no field with [fieldName] exists.
  List<CheckboxFieldState<T>> checkboxesOf<T>(String fieldName) {
    return get<CheckboxGroupFieldState<T>, Set<T>?>(fieldName).checkboxes;
  }

  /// Fetches the set of values for checkboxes associated with a given field name.
  ///
  /// This utility method simplifies the process of retrieving the selected values
  /// for a checkbox group field within the form. The method is generic and works for
  /// checkboxes of any type `T`.
  ///
  /// [fieldName] is the name of the field whose checkbox values you want to retrieve.
  ///
  /// Returns a set of selected values for the checkboxes of type `T`.
  ///
  /// Example:
  /// ```dart
  /// final selectedToppings = formState.checkboxValues<PizzaTopping>('toppings');
  /// ```
  Set<T>? checkboxValues<T>(String fieldName) {
    return get<CheckboxGroupFieldState<T>, Set<T>?>(fieldName).value;
  }

  /// Fetches the first selected value for checkboxes associated with a given field name.
  ///
  /// This utility method retrieves the first selected checkbox value for a particular
  /// field within the form. If no checkbox is selected, it returns null.
  ///
  /// [fieldName] is the name of the field whose first checkbox value you want to retrieve.
  ///
  /// Returns the first selected value of type `T` or null if no checkboxes are selected.
  ///
  /// Example:
  /// ```dart
  /// final firstTopping = formState.checkboxValue<PizzaTopping>('toppings');
  /// ```
  T? checkboxValue<T>(String fieldName) {
    return checkboxValues<T>(fieldName)?.firstOrNull;
  }
}
