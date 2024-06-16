import 'package:bond_cache/src/helpers/common_cache_helper.dart';
import 'package:meta/meta.dart';

part 'cache_data.dart';

/// Represents a cache driver that can retrieve, store, check existence, forget,
/// and flush cached data.
abstract class CacheDriver {
  /// Retrieves cached data of type [T] associated with the specified [key].
  ///
  /// If the cache does not contain the specified key, it returns the
  /// [defaultValue], if provided; otherwise, it returns the default value for
  /// type [T]. If the cached data is invalid or an error occurs during decoding,
  /// it removes the key from the cache and returns the default value.
  ///
  /// - Parameters:
  ///   - [key] The key associated with the cached data.
  ///   - [defaultValue] The default value or function returning the value.
  /// - Returns: The cached data of type [T] or the default value if not found or invalid.
  /// - Throws: [ArgumentError] if the value type is not supported.
  @internal
  T get<T>(String key, {dynamic defaultValue, Factory<T>? fromJsonFactory}) {
    if (!has(key)) {
      return CommonCacheHelper.checkDefaultValue<T>(defaultValue);
    }
    final cachedData = retrieve(key);
    if (cachedData == null) {
      return CommonCacheHelper.checkDefaultValue<T>(defaultValue);
    }
    final cachedObject = CacheData.fromJson(cachedData);
    if (cachedObject.isValid) {
      final result = CommonCacheHelper.checkCachedData<T>(
        cachedObject.data,
        fromJsonFactory: fromJsonFactory,
      );
      return result;
    } else {
      forget(key);
      return CommonCacheHelper.checkDefaultValue<T>(defaultValue);
    }
  }

  /// Retrieves a list of cached data associated with the specified [key].
  ///
  /// If the cache does not contain the specified key, it returns the
  /// [defaultValue], if provided; otherwise, it returns the default value for
  /// type [List<T>]. If the cached data is invalid or an error occurs during decoding,
  /// it removes the key from the cache and returns the default value.
  ///
  /// - Parameters:
  ///   - [key] The key associated with the cached data.
  ///   - [defaultValue] The default value or function returning the value.
  ///   - [fromJsonFactory] The factory function for deserialization of the list elements.
  /// - Returns: The list of cached data of type [T] or the default value if not found or invalid.
  /// - Throws: [ArgumentError] if the value type is not supported.
  @internal
  List<T> getAll<T>(
    String key, {
    dynamic defaultValue,
    Factory<T>? fromJsonFactory,
  }) {
    if (!has(key)) {
      return CommonCacheHelper.checkDefaultValue<List<T>>(defaultValue);
    }
    final cachedData = retrieve(key);
    if (cachedData == null) {
      return CommonCacheHelper.checkDefaultValue<List<T>>(defaultValue);
    }
    final cachedObject = CacheData.fromJson(cachedData);
    if (cachedObject.isValid) {
      final result = CommonCacheHelper.convertList<T>(
        cachedObject.data,
        fromJsonFactory: fromJsonFactory,
      );
      return result;
    } else {
      forget(key);
      return CommonCacheHelper.checkDefaultValue<List<T>>(defaultValue);
    }
  }

  /// Stores the provided value of type [T] in the cache associated with the specified [key].
  ///
  /// Optionally, an expiration duration can be provided to set the validity period
  /// of the cached data.
  ///
  /// - Parameters:
  ///   - [key] The key associated with the cached data.
  ///   - [value] The value to be stored in the cache.
  ///   - [expiredAfter] The duration for which the cached data is valid.
  /// - Returns: A [Future] that completes with a [bool] indicating the success of the operation.
  /// - Throws: [ArgumentError] if the value type is not supported.
  @internal
  Future<bool> put<T>(String key, T value, [Duration? expiredAfter]) {
    final result =
        CommonCacheHelper.convertToCacheValue<T>(value, expiredAfter);
    return store(key, result);
  }

  /// Convenience method to store a list of items of type [T] in the cache.
  /// This is equivalent to calling [put] with the type [List<T>].
  /// - Parameter key: The key associated with the
  ///   - [key] The key associated with the cached data.
  ///   - [value] The value to be stored in the cache.
  ///   - [expiredAfter] The duration for which the cached data is valid.
  /// - returns: A [Future] that completes with a [bool] indicating the success of the operation.
  /// - Throws: [ArgumentError] if the value type is not supported.
  Future<bool> putAll<T>(String key, List<T> value, [Duration? expiredAfter]) =>
      put<List<T>>(key, value, expiredAfter);

  /// Checks if the cache contains data associated with the specified [key].
  ///
  /// - Parameters:
  ///   - [key] The key to check for existence in the cache.
  /// - Returns: A [bool] indicating whether the cache contains data for the specified key.
  bool has(String key);

  /// Retrieves cached data as a string associated with the specified [key].
  ///
  /// - Parameters:
  ///   - [key] The key associated with the cached data.
  /// - Returns: A [String] representation of the cached data or `null` if not found.
  Json? retrieve(String key);

  /// Stores the provided string [data] in the cache associated with the specified [key].
  ///
  /// - Parameters:
  ///   - [key] The key associated with the cached data.
  ///   - [data] The Json representation of the data to be stored in the cache.
  /// - Returns: A [Future] that completes with a [bool] indicating the success of the operation.
  Future<bool> store(String key, Json data);

  /// Removes cached data associated with the specified [key] from the cache.
  ///
  /// - Parameters:
  ///   - [key] The key associated with the cached data to be forgotten.
  /// - Returns: A [Future] that completes with a [bool] indicating the success of the operation.
  Future<bool> forget(String key);

  /// Clears all cached data, effectively flushing the entire cache.
  ///
  /// - Returns: A [Future] that completes with a [bool] indicating the success of the operation.
  Future<bool> flush();
}
