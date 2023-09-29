/// A mixin providing a dynamic response conversion method.
///
/// This mixin offers a flexible way for service providers to convert JSON data into
/// their associated models or entities. When a class mixes in `ResponseDecoding`, it
/// can override [responseConvert] to implement custom conversion logic.
///
/// It's typically used in conjunction with [ServiceProvider] implementations to
/// offer a unified method for transforming JSON data into app-specific models.
///
/// The method [responseConvert] is expected to be overridden by classes that mix in
/// `ResponseDecoding`. If no conversion is defined, it defaults to returning `null`.
///
/// Usage:
///
/// ```dart
/// class MyServiceProvider with ResponseDecoding {
///   @override
///   T? responseConvert<T>(Map<String, dynamic> json) {
///     if (T == MyModel) {
///       return MyModel.fromJson(json) as T;
///     }
///     // Add other model conversions as needed...
///     return null;
///   }
/// }
/// ```
mixin ResponseDecoding {
  /// Converts a JSON map into an instance of type [T], if supported.
  ///
  /// Override this method in classes that mix in [ResponseDecoding] to
  /// implement custom conversion logic for different models or entities.
  ///
  /// - Parameter [json]: The JSON map that needs to be converted.
  /// - Returns: An instance of type [T] if the conversion is successful; otherwise, `null`.
  T? responseConvert<T>(Map<String, dynamic> json);
}
