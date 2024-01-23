import '../cache/cache_driver.dart';

class InMemoryCacheDriver extends CacheDriver {
  final Map<String, String> _cache = {};

  @override
  String? retrieve(String key) {
    return _cache[key];
  }

  @override
  Future<bool> store(String key, String data) async {
    _cache[key] = data;
    return true;
  }

  @override
  Future<bool> flush() async {
    _cache.clear();
    return true;
  }

  @override
  Future<bool> forget(String key) async {
    _cache.remove(key);
    return true;
  }

  @override
  bool has(String key) => _cache.containsKey(key);
}
