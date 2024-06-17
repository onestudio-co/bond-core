import 'package:bond_cache/src/helpers/common_cache_helper.dart';

abstract class CacheDriver {
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
  /// - Parameter [key] The key associated with the cached data to be removed.
  /// - Returns: A [Future] that completes with a [bool] indicating the success of the operation.
  Future<bool> remove(String key);

  // Removes all cached data from the cache.
  /// - Returns: A [Future] that completes with a [bool] indicating the success of the operation.
  Future<bool> removeAll();
}
