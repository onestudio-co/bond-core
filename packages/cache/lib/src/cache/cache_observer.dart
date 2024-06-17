part of 'bond_cache.dart';

abstract class CacheObserver {
  void onUpdate<T>(String key, T newValue);

  void onDelete(String key);
}
