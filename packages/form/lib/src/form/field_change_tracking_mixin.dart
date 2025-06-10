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

  /// Add a listener for a specific field's changes and returns the current field value
  void addFieldListener<T>(String fieldName, void Function(T) listener) {
    _fieldListeners
        .putIfAbsent(fieldName, () => [])
        .add(listener as void Function(dynamic));
  }

  /// Remove a listener for a specific field's changes
  void removeFieldListener(String fieldName, void Function(dynamic) listener) {
    _fieldListeners[fieldName]?.remove(listener);
    if (_fieldListeners[fieldName]?.isEmpty ?? false) {
      _fieldListeners.remove(fieldName);
    }
  }

  /// Called when a field is updated to notify any registered listeners
  void notifyFieldListeners<T>(String field, T value) {
    _fieldListeners[field]?.forEach((listener) {
      listener(value);
    });
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
