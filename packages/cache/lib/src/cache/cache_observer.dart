part of 'bond_cache.dart';

extension CacheObserverList on List<CacheObserver> {
  bool containsObserver(CacheObserver observer) {
    return whereType<ObserverWrapper>().any((o) => o.observer == observer);
  }
}

abstract class CacheObserver<T> {
  void onUpdate(String key, T newValue);

  void onDelete(String key);
}

class ObserverWrapper implements CacheObserver {
  final CacheObserver observer;
  final String key;
  final String identifier;

  ObserverWrapper(this.observer, this.key)
      : identifier = _generateUniqueId(key);

  static String _generateUniqueId(String key) {
    return '${DateTime.now().microsecondsSinceEpoch}_$key';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ObserverWrapper && other.identifier == identifier;
  }

  @override
  int get hashCode => identifier.hashCode;

  @override
  void onDelete(String key) {
    observer.onDelete(key);
  }

  @override
  void onUpdate(String key, dynamic newValue) {
    observer.onUpdate(key, newValue);
  }
}

class ICacheObserver<T> implements CacheObserver<T> {
  final StreamController<T> controller;
  final void Function(String key, T value) mOnUpdate;
  final void Function(String key) mOnDelete;

  ICacheObserver(
    this.controller, {
    required void Function(String key, T value) onUpdate,
    required void Function(String key) onDelete,
  })  : mOnUpdate = onUpdate,
        mOnDelete = onDelete;

  @override
  void onDelete(String key) {
    mOnDelete(key);
  }

  @override
  void onUpdate(String key, T newValue) {
    mOnUpdate(key, newValue);
  }
}
