part of 'bond_cache.dart';

extension CacheObserverList on List<CacheObserver> {
  bool containsObserver(CacheObserver observer) {
    return whereType<ObserverWrapper>().any((o) => o.observer == observer);
  }

  bool removeObserver(CacheObserver observer) {
    if (observer is ObserverWrapper) {
      if (observer.observer is StreamCacheObserver) {
        final streamObserver = observer.observer as StreamCacheObserver;
        streamObserver.controller.close();
      }
    }
    return remove(observer);
  }
}

abstract class CacheObserver<T> {
  void onUpdate(String key, T newValue);

  void onDelete(String key);
}

class ObserverWrapper<T> implements CacheObserver<T> {
  final CacheObserver<T> observer;
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
  void onUpdate(String key, T newValue) {
    observer.onUpdate(key, newValue);
  }
}

class StreamCacheObserver<T> implements CacheObserver<T> {
  final StreamController<T> controller;

  StreamCacheObserver(this.controller);

  @override
  void onDelete(String key) {
    controller.close();
  }

  @override
  void onUpdate(String key, T newValue) {
    controller.add(newValue);
  }
}
