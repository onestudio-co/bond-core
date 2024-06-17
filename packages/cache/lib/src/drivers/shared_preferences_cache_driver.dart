import 'dart:convert';

import 'package:bond_cache/src/helpers/common_cache_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cache/cache_driver.dart';

/// A cache driver implementation using the `SharedPreferences` library for
/// storing and retrieving cached data.
///
/// This class extends the [CacheDriver] abstract class and provides
/// functionality to interact with the `SharedPreferences` storage.
class SharedPreferencesCacheDriver extends CacheDriver {
  final SharedPreferences _sharedPreferences;

  /// Creates an instance of [SharedPreferencesCacheDriver] with the provided
  /// `SharedPreferences` instance.
  ///
  /// - Parameters:
  ///   - [_sharedPreferences] The `SharedPreferences` instance for caching.
  SharedPreferencesCacheDriver(this._sharedPreferences);

  /// Retrieves cached data as a JSON [Map] associated with the specified [key].
  ///
  /// - Parameters:
  ///   - [key] The key associated with the cached data.
  /// - Returns: A [Json] representation of the cached data, or `null` if not found.
  @override
  Json? retrieve(String key) {
    final value = _sharedPreferences.getString(key);
    if (value != null) {
      return jsonDecode(value);
    }
    return null;
  }

  /// Stores the provided JSON [data] in the cache associated with the specified [key].
  ///
  /// - Parameters:
  ///   - [key] The key associated with the cached data.
  ///   - [data] The JSON data to be stored in the cache.
  /// - Returns: A [Future] that completes with a [bool] indicating the success
  ///   of the operation.
  @override
  Future<bool> store(String key, Json data) =>
      _sharedPreferences.setString(key, jsonEncode(data));

  /// Checks if the cache contains data associated with the specified [key].
  ///
  /// - Parameters:
  ///   - [key] The key to check for existence in the cache.
  /// - Returns: A [bool] indicating whether the cache contains data for the specified key.
  @override
  bool has(String key) => _sharedPreferences.containsKey(key);

  /// Removes cached data associated with the specified [key] from the cache.
  ///
  /// - Parameters:
  ///   - [key] The key associated with the cached data to be forgotten.
  /// - Returns: A [Future] that completes with a [bool] indicating the success
  ///   of the operation.
  @override
  Future<bool> remove(String key) => _sharedPreferences.remove(key);

  /// Clears all cached data, effectively flushing the entire cache.
  ///
  /// - Returns: A [Future] that completes with a [bool] indicating the success
  ///   of the operation.
  @override
  Future<bool> removeAll() => _sharedPreferences.clear();
}
