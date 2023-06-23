import 'dart:convert';
import 'package:bond_core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cache_driver.dart';

class SharedPreferencesCacheDriver implements CacheDriver {
  final SharedPreferences _sharedPreferences;

  SharedPreferencesCacheDriver(this._sharedPreferences);

  @override
  CacheDriverReturnType<T> get<T>(String key,
      {dynamic defaultValue, FromJsonFactory? factory}) {
    final stringCache = _sharedPreferences.getString(key);
    if (stringCache == null) return _handleDefaultValue(defaultValue);
    final Map<String, dynamic> jsonCache = jsonDecode(stringCache);
    final CacheData cache = CacheData.fromJson(jsonCache);
    if (cache.isValid) {
      return Future.value(factory == null ? cache.data : factory(cache.data));
    }
    _sharedPreferences.remove(key);
    return _handleDefaultValue(defaultValue);
  }

  @override
  Future<bool> has(String key) async => _sharedPreferences.containsKey(key);

  @override
  Future<bool> put(String key, dynamic value, [Duration? expiredAfter]) async {
    final CacheData cache = CacheData(
      data: value,
      expiredAt: expiredAfter == null ? null : DateTime.now().add(expiredAfter),
    );
    if (value is Jsonable) {
      value = jsonEncode(value.toJson());
    } else if (value is List<Jsonable>) {
      value = jsonEncode(value.map((e) => e.toJson()).toList());
    }
    final String stringCache = jsonEncode(cache.toJson());
    return _sharedPreferences.setString(key, stringCache);
  }

  @override
  Future<bool> forget(String key) => _sharedPreferences.remove(key);

  @override
  Future<bool> flush() => _sharedPreferences.clear();

  CacheDriverReturnType<T> _handleDefaultValue<T>(dynamic defaultValue) {
    if (defaultValue is Function) {
      return Future.value(defaultValue());
    } else {
      return Future.value(defaultValue);
    }
  }
}
