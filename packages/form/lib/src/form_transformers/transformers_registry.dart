import 'dart:convert';
import 'field_transformer.dart';

/// A registry for managing field transformers, allowing custom
/// transformations of form field values based on their types.
class TransformersRegistry {
  final factories = <Type, FieldTransformerFactory<dynamic, Object>>{};

  /// Registers a transformer function for a specific field type.
  ///
  /// Parameters:
  ///   - [T] The type of the field value that the transformer handles.
  ///   - [G] The type that the field value should be transformed into.
  ///   - [transformationFunction] The function that performs the transformation.
  void register<T, G extends Object>(
    FieldTransformer<T, G> transformationFunction,
  ) {
    final fieldTransformerFactory = FieldTransformerFactory<T, G>(
      transformationFunction: transformationFunction,
    );
    factories[T] = fieldTransformerFactory;
  }

  /// Transforms a field value using the appropriate transformer
  /// registered for its type.
  ///
  /// Parameters:
  ///   - [value] The field value to be transformed.
  ///
  /// Returns: The transformed value, or the original value if no transformer
  /// is registered for its type.
  dynamic transform(dynamic value) {
    final transformer = factories[value.runtimeType];

    // If no transformer is found, check if there is a transformer for the base type
    if (transformer == null && value is Iterable) {
      // Handle cases where the runtime type might be a collection type like Set or List
      if (value is Set) {
        return _transformCollection<Set>(value);
      } else if (value is List) {
        return _transformCollection<List>(value);
      }
    }
    return transformer?.transform(value);
  }

  /// Transforms a collection of values using the appropriate transformer
  /// registered for the type of elements in the collection.
  ///
  /// Parameters:
  ///   - [C] The type of the collection (e.g., Set, List).
  ///   - [collection] The collection of values to be transformed.
  ///
  /// Returns: A JSON-encoded string of the transformed collection.
  dynamic _transformCollection<C extends Iterable>(C collection) {
    final firstElementType =
        collection.isNotEmpty ? collection.first.runtimeType : null;
    if (firstElementType != null) {
      final transformer = factories[firstElementType];
      if (transformer != null) {
        return jsonEncode(
          collection.map((item) => transformer.transform(item)).toList(),
        );
      }
    }
    return collection;
  }
}
