import 'dart:convert';

import 'package:bond_core/bond_core.dart';

/// A typedef representing a JSON object commonly used in Dart applications.
///
/// This typedef defines a [Json] type, which is essentially a [Map] with
/// [String] keys and [dynamic] values, typically used to represent JSON data.
/// Usage:
/// ```dart
/// Json jsonData = {'key': 'value', 'number': 42};
/// ```
typedef Json = Map<String, dynamic>;

/// A typedef representing a factory function for deserialization.
///
/// This typedef defines a [Factory<T>] type, which is a function that takes
/// a [Map<String, dynamic>] and returns an instance of type [T]. It is commonly
/// used for converting JSON data into Dart objects or entities.
/// Usage:
/// ```dart
/// Factory<MyModel> myModelFactory = (json) => MyModel.fromJson(json);
/// ```
typedef Factory<T> = T Function(Map<String, dynamic>);

/// An extension providing a `primitive` property for checking if an object is a primitive type.
///
/// This extension adds a `primitive` property to all objects, allowing you to easily check
/// whether an object is of a primitive type (int, double, String, bool, or lists of these types).
/// It can be used to determine if an object is suitable for caching purposes.
///
/// Usage:
/// ```dart
/// var isPrimitive = myObject.primitive;
/// ```
extension xDynamic on Object {
  bool get primitive {
    return this is int ||
        this is double ||
        this is String ||
        this is bool ||
        this is List<int> ||
        this is List<double> ||
        this is List<String> ||
        this is List<bool>;
  }
}

/// An extension on the [Type] class providing utility methods for type checks.
/// Checks whether the type is a primitive type or a list of primitive types.
///
/// Returns `true` if the type is [int], [double], [String], [bool], or a list of [int],
/// [double], [String], or [bool]. Otherwise, returns `false`.
///
/// Usage:
/// ```dart
/// bool isPrimitive = T.primitive; // true
/// ```
extension on Type {
  bool get primitive {
    final listInt = this == List<int>;
    final listDouble = this == List<double>;
    final listString = this == List<String>;
    final listBool = this == List<bool>;
    final listPrimitive = listInt || listDouble || listString || listBool;
    return this == int ||
        this == double ||
        this == String ||
        this == bool ||
        listPrimitive;
  }
}

/// A helper class providing methods for common cache-related operations.
class CommonCacheHelper {
  /// Converts the provided [value] to a cache-friendly string representation.
  ///
  /// This method checks the type of [value] and returns the appropriate string
  /// representation for caching purposes. It supports [Jsonable] objects,
  /// lists of [Jsonable], primitive types (num, String, bool), and lists of
  /// primitive types.
  ///
  /// If the type is unsupported, it throws an [ArgumentError] with a descriptive error message.
  ///
  /// - Parameters:
  ///   - [value] The value to convert.
  /// - Returns: The string representation of the value.
  /// - Throws: An [ArgumentError] if [value] is of an unsupported type.
  /// Usage:
  /// ```dart
  /// var result = CommonCacheHelper.convertToCacheValue(myValue);
  /// ```
  static String convertToCacheValue<T>(T value) {
    if (value is Jsonable) {
      return jsonEncode(value.toJson());
    } else if (value is List<Jsonable>) {
      return jsonEncode(value.map((e) => e.toJson()).toList());
    } else if (value?.primitive ?? false) {
      return jsonEncode(value);
    } else {
      throw ArgumentError('Unsupported type or value: $value. '
          '[value] type must be Jsonable, List<>, '
          'a primitive type, or List<primitive type>.');
    }
  }

  /// Checks and retrieves the cached data of type [T].
  ///
  /// This method validates that the [cachedValue] is of type [T] if it's a primitive type.
  /// If [cachedValue] is a map, it attempts to convert it to type [T] using the provided
  /// [fromJsonFactory] if available. If [fromJsonFactory] is not provided, it checks for
  /// a suitable [ResponseDecoding] provider for conversion.
  ///
  /// - Parameters:
  ///   - [cachedValue] The cached data to check and retrieve.
  ///   - [fromJsonFactory] An optional factory function for custom deserialization.
  /// - Returns: The cached data converted to type [T].
  /// - Throws: An [ArgumentError] if [cachedValue] cannot be converted to type [T].
  /// /// Usage:
  /// ```dart
  /// var result = CommonCacheHelper.checkCachedData(myValue, fromJsonFactory: User.fromJson);
  /// ```
  static T checkCachedData<T>(
    dynamic cachedValue, {
    Factory<T>? fromJsonFactory,
  }) {
    if (T.primitive) {
      assert(
        cachedValue is T,
        'Cached value must be of type $T, but was ${cachedValue.runtimeType}',
      );
      return cachedValue as T;
    }

    if (cachedValue is Map<String, dynamic>) {
      if (fromJsonFactory != null) {
        return fromJsonFactory!(cachedValue);
      }
      for (final provider in appProviders.whereType<ResponseDecoding>()) {
        final model = provider.responseConvert<T>(cachedValue);
        if (model != null) {
          return model;
        }
      }
      throw ArgumentError(
        'No ResponseDecoding provider found for type $T. '
        'Make sure to register a class that implements ResponseDecoding '
        'and provides a responseConvert method for type $T. '
        'To register a ResponseDecoding provider, you can do the following:\n\n'
        'class MyServiceProvider extends ServiceProvider with ResponseDecoding {\n'
        '  @override\n'
        '  T? responseConvert<T>(Map<String, dynamic> json) {\n'
        '    if (T == $T) {\n'
        '      return $T.fromJson(json) as T;\n'
        '    }\n'
        '    // Add other model conversions as needed...\n'
        '    return null;\n'
        '  }\n'
        '}\n',
      );
    }

    // Throw an error if T is not a primitive type and provider.responseConvert returns null
    throw ArgumentError(
        'Unhandled case for type $T and cached value: $cachedValue');
  }

  /// Checks and retrieves the default value of type [T].
  ///
  /// This method validates that the [defaultValue] is of type [T], or it is
  /// a function returning a value of type [T].
  /// It then returns the appropriate value.
  ///
  /// - Parameters:
  ///   - [defaultValue: The default value or function returning the value.
  /// - Returns: The value of type [T].
  /// - Throws: An [ArgumentError] if the [defaultValue] does not match the expected
  ///   types or if an error occurs while awaiting a future.
  ///
  /// Usage:
  /// ```dart
  /// var value =  checkDefaultValue<int>(42);
  /// ```
  static T checkDefaultValue<T>(dynamic defaultValue) {
    if (defaultValue is T) {
      return defaultValue;
    }

    if (defaultValue is T Function()) {
      return defaultValue();
    }

    throw ArgumentError(
      'defaultValue must be of type $T or a function returning $T',
    );
  }
}
