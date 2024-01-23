import 'package:shared_preferences/shared_preferences.dart';

import '../cache/cache_driver.dart';

class SharedPreferencesCacheDriver extends CacheDriver {
  final SharedPreferences _sharedPreferences;

  SharedPreferencesCacheDriver(this._sharedPreferences);

  @override
  String? retrieve(String key) => _sharedPreferences.getString(key);

  @override
  Future<bool> store(String key, String data) async =>
      _sharedPreferences.setString(key, data);

  @override
  bool has(String key) => _sharedPreferences.containsKey(key);

  @override
  Future<bool> forget(String key) => _sharedPreferences.remove(key);

  @override
  Future<bool> flush() => _sharedPreferences.clear();
}
