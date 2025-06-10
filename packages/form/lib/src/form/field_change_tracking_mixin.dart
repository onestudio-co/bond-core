import 'package:bond_form/bond_form.dart';
import 'package:meta/meta.dart';

/// A mixin that provides field value change tracking functionality for forms.
///
/// This mixin allows tracking changes in form field values by maintaining initial values
/// and providing methods to check if fields have been modified. It also supports field
/// change listeners for reactive programming patterns.
mixin FieldChangeTrackingMixin<Success, Failure extends Error>
    on BaseFormController<Success, Failure, BondFormState<Success, Failure>> {
  // Store initial field values for change tracking
  final Map<String, dynamic> _initialFieldValues = {};

  // Store field change listeners
  final Map<String, List<void Function(dynamic)>> _fieldListeners = {};

  /// Initialize field tracking for change detection
  @protected
  void initializeFieldTracking() {
    for (final entry in state.fields.entries) {
      _initialFieldValues[entry.key] = entry.value.value;
    }
  }

  /// Check if a specific field's value has changed from its initial value
  bool hasFieldChanged(String fieldName) {
    if (!state.fields.containsKey(fieldName)) return false;
    if (!_initialFieldValues.containsKey(fieldName)) return true;
    return state.fields[fieldName]!.value != _initialFieldValues[fieldName];
  }

  /// Add a listener for a specific field's changes
  void addFieldListener(String fieldName, void Function(dynamic) listener) {
    _fieldListeners.putIfAbsent(fieldName, () => []).add(listener);
  }

  /// Remove a listener for a specific field's changes
  void removeFieldListener(String fieldName, void Function(dynamic) listener) {
    _fieldListeners[fieldName]?.remove(listener);
    if (_fieldListeners[fieldName]?.isEmpty ?? false) {
      _fieldListeners.remove(fieldName);
    }
  }

  /// Called when a field is updated to notify any registered listeners
  void notifyFieldListeners(String field, dynamic value) {
    _fieldListeners[field]?.forEach((listener) => listener(value));
  }

  /// resets the initial field values
  void resetInitialFieldsValue() {
    _initialFieldValues.clear();
    for (final entry in state.fields.entries) {
      _initialFieldValues[entry.key] = entry.value.value;
    }
  }

  /// Cleans up tracking resources
  @protected
  void disposeTracking() {
    _fieldListeners.clear();
    _initialFieldValues.clear();
  }
}
