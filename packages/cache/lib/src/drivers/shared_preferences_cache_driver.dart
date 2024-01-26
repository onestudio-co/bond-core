import 'dart:convert';

import 'package:bond_cache/src/helpers/common_cache_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cache/cache_driver.dart';

class SharedPreferencesCacheDriver extends CacheDriver {
  final SharedPreferences _sharedPreferences;

  SharedPreferencesCacheDriver(this._sharedPreferences);

  @override
  Json? retrieve(String key) {
    final value = _sharedPreferences.getString(key);
    if (value != null) {
      return jsonDecode(value);
    }
    return null;
  }

  @override
  Future<bool> store(String key, Json data) async =>
      _sharedPreferences.setString(key, jsonEncode(data));

  @override
  bool has(String key) => _sharedPreferences.containsKey(key);

  @override
  Future<bool> forget(String key) => _sharedPreferences.remove(key);

  @override
  Future<bool> flush() => _sharedPreferences.clear();
}
