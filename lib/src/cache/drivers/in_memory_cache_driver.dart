import 'dart:convert';

import 'package:one_studio_core/core.dart';

class InMemoryCacheDriver implements CacheDriver {
  final Map<String, String> _cache = {};

  @override
  Future<bool> flush() {
    _cache.clear();
    return Future.value(true);
  }

  @override
  Future<bool> forget(String key) {
    _cache.remove(key);
    return Future.value(true);
  }

  @override
  CacheDriverReturnType<T> get<T>(String key,
      {defaultValue, FromJsonFactory? factory}) {
    if (!_cache.containsKey(key)) {
      return Future.value(_handleDefaultValue(defaultValue));
    } else {
      final jsonCache = jsonDecode(_cache[key]!);
      final cache = CacheData.fromJson(jsonCache);
      if (cache.isValid) {
        return Future.value(factory == null ? cache.data : factory(cache.data));
      }
      _cache.remove(key);
      return _handleDefaultValue(defaultValue);
    }
  }

  @override
  Future<bool> has(String key) => Future.value(_cache.containsKey(key));

  @override
  Future<bool> put(String key, value, [Duration? expiredAfter]) {
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
    _cache[key] = stringCache;
    return Future.value(true);
  }

  CacheDriverReturnType<T> _handleDefaultValue<T>(dynamic defaultValue) {
    if (defaultValue is Function) {
      return Future.value(defaultValue());
    } else {
      return Future.value(defaultValue);
    }
  }
}
