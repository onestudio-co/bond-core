import 'package:bond_form/bond_form.dart';

/// Extension methods for [BaseFormController] to manage async dropdown items.
///
/// The `FormControllerUpdateItemsExtension` provides utility methods for dynamically
/// modifying the cached item list of [AsyncDropDownFieldState] within a form controller.
///
/// These methods are particularly useful in scenarios like inline creation, dynamic updates,
/// or injecting new options into dropdowns without waiting for the API to refetch.
///
/// Example usage:
/// ```dart
/// // Insert a new item at the top of the dropdown
/// formController.insertAsyncDropDownItem<String>(
///   'addressId',
///   value: '123',
///   label: 'New Address',
/// );
///
/// // Update the label of an existing item
/// formController.updateAsyncDropDownItem<String>(
///   'addressId',
///   value: '123',
///   label: 'Updated Address Name',
/// );
/// ```
///
/// Methods:
/// - [insertAsyncDropDownItem] Adds a new dropdown item to the cached list at a given index.
/// - [updateAsyncDropDownItem] Updates the label of an existing cached dropdown item.
extension FormControllerUpdateItemsExtension on BaseFormController {
  /// Inserts a new [value] into the items list of an [AsyncDropDownFieldState].
  ///
  /// This method allows dynamically adding a new item to the dropdown field,
  /// which is useful for supporting inline creation or external injection of values.
  ///
  /// - [fieldName]: The name of the async dropdown field to update.
  /// - [value]: The new item to insert into the dropdown list.
  /// - [index]: The position in the list where the new item should be inserted (default is `0`, i.e., top of the list).
  void insertAsyncDropDownItem<T>(
    String fieldName, {
    required T value,
    required String label,
    int index = 0,
  }) {
    final field = state.asyncDropDownField<T>(fieldName);
    final cached = List<DropDownItemState<T>>.from(field.cachedItems ?? []);
    cached.insert(index, DropDownItemState<T>(value, label: label));
    state.fields[fieldName] = field.copyWith(cachedItems: cached);
    state = state.copyWith(fields: state.fields);
  }

  /// Updates an existing dropdown item in an [AsyncDropDownFieldState] by its value.
  ///
  /// - [fieldName]: The name of the dropdown field.
  /// - [value]: The value to search for and update.
  /// - [label]: The new label for the existing item.
  ///
  /// If the item doesn't exist, this method does nothing.
  void updateAsyncDropDownItem<T>(
    String fieldName, {
    required T value,
    required String label,
  }) {
    final field = state.asyncDropDownField<T>(fieldName);
    final cached = List<DropDownItemState<T>>.from(field.cachedItems ?? []);

    final index = cached.indexWhere((item) => item.value == value);
    if (index == -1) return; // Value not found; exit

    cached[index] = DropDownItemState<T>(value, label: label);

    state.fields[fieldName] = field.copyWith(cachedItems: cached);
    state = state.copyWith(fields: state.fields);
  }
}
