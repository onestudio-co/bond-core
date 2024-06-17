import 'package:bond_cache/src/cache/cache_driver.dart';
import 'package:bond_cache/src/helpers/common_cache_helper.dart';

/// An in-memory cache driver that stores data in a local map.
///
/// This driver is useful for testing or scenarios where a simple,
/// non-persistent, in-memory cache is sufficient.
class InMemoryCacheDriver extends CacheDriver {
  /// The in-memory map used to store cached data.
  final Map<String, Json> _cache = {};

  /// Retrieves the cached data associated with the given [key].
  ///
  /// If the [key] is not found in the cache, it returns `null`.
  @override
  Json? retrieve(String key) => _cache[key];

  /// Stores the provided [data] in the cache with the specified [key].
  ///
  /// Returns `true` to indicate a successful storage operation.
  @override
  Future<bool> store(String key, Json data) async {
    _cache[key] = data;
    return true;
  }

  /// Clears all data from the in-memory cache.
  ///
  /// Returns `true` to indicate a successful flush operation.
  @override
  Future<bool> removeAll() async {
    _cache.clear();
    return true;
  }

  /// Removes the cached data associated with the given [key].
  ///
  /// Returns `true` to indicate a successful removal operation.
  @override
  Future<bool> remove(String key) async {
    return _cache.remove(key) != null;
  }

  /// Checks if the cache contains data associated with the given [key].
  ///
  /// Returns `true` if the key exists in the cache; otherwise, `false`.
  @override
  bool has(String key) => _cache.containsKey(key);
}
