import 'package:bond_form/bond_form.dart';

/// A mixin that adds functionality to convert form state into a
/// map of key-value pairs suitable for creating a request body.
mixin BodyConvertible<Success, Failure extends Error,
        State extends BaseBondFormState<Success, Failure>>
    on BaseFormController<Success, Failure, State> {
  /// Generates a map from the form state, applying any transformations
  /// specified by the `fieldTransformers` method.
  ///
  /// This method iterates over all fields in the form state, applies
  /// any registered transformers, and returns a map suitable for use
  /// as a request body.
  ///
  /// Returns: A `Map<String, dynamic>` containing the transformed form data.
  Map<String, dynamic> body() {
    final _registry = TransformersRegistry();
    fieldTransformers(_registry);

    final map = <String, dynamic>{};

    // Iterate through each field in the fields map
    state.fields.forEach((fieldName, fieldState) {
      final fieldValue = fieldState.value;
      final newValue = _registry.transform(fieldValue, fieldKey: fieldName);
      map[fieldName] = newValue ?? fieldValue;
    });

    return map;
  }

  /// Registers transformers for specific field types.
  ///
  /// Subclasses should implement this method to register any custom
  /// transformers needed to convert field values to the appropriate
  /// types for the request body.
  ///
  /// Parameters:
  ///   - [registry] The `TransformersRegistry` instance where
  ///                 transformers should be registered.
  void fieldTransformers(TransformersRegistry registry) {}
}
