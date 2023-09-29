import 'dart:convert';

/// A mixin that provides JSON serialization methods.
///
/// Classes that include this mixin must implement [toJson] method,
/// which converts the object to a JSON-compatible map.
mixin Jsonable {
  /// Converts the object to a JSON-compatible map.
  ///
  /// Implement this method in classes that use this mixin
  /// to provide custom serialization to JSON.
  Map<String, dynamic> toJson();

  /// Converts the object to a JSON-formatted string.
  ///
  /// This method calls [toJson] to get a JSON-compatible map
  /// and then encodes it as a JSON-formatted string.
  ///
  /// ```
  /// final jsonString = myObject.toJsonString();
  /// ```
  String toJsonString() => json.encode(toJson());
}
