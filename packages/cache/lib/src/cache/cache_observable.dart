part of 'bond_cache.dart';

/// A mixin that adds observable capabilities to a cache system.
/// It allows objects to watch changes to specific cache keys and get notified when
/// those keys are updated or deleted. Observers must implement the [CacheObserver] interface.
///
/// This mixin provides methods to add and remove observers for specific keys,
/// and to notify these observers when changes occur.
///
/// Usage:
/// A cache class can include this mixin to allow other parts of the application
/// to react to cache updates or deletions.
mixin CacheObservable {
  /// Stores observers for each cache key. Observers are notified when the key they are watching is modified.
  final Map<String, List<CacheObserver>> _observers = {};

  /// A constant for representing notifications for all keys.
  static const String allKeys = '*';

  /// Adds an observer for a specific cache key.
  ///
  /// - Parameters:
  ///   -[key] The cache key to watch.
  ///   -[observer] The observer that will be notified when the key is updated or deleted.
  void watch(String key, CacheObserver observer) {
    _observers.putIfAbsent(key, () => []).add(observer);
  }

  /// Removes an observer for a specific cache key.
  ///
  /// - Parameters:
  ///   - [key] The cache key the observer is watching.
  ///   - [observer] The observer to remove.
  /// If all observers for a key are removed, the key entry is also removed from the observers map.
  void unwatch(String key, CacheObserver observer) {
    _observers[key]?.remove(observer);
    if (_observers[key]?.isEmpty ?? true) {
      _observers.remove(key);
    }
  }

  /// Notifies all observers watching a specific key about a change.
  ///
  /// - Parameters:
  ///   - [key] The cache key that has been updated.
  ///   - [newValue] The new value of the key after the update.
  /// Each observer's [onUpdate] method is called with the new value.
  @protected
  void notifyObservers<T>(String key, T newValue) {
    _observers[key]?.forEach((observer) {
      observer.onUpdate(key, newValue);
    });
  }

  /// Notifies observers about the deletion of a key. If the special key [allKeys] is used,
  /// all observers for all keys are notified, and the observers map is cleared.
  ///
  /// - Parameters:
  ///   - [key] The cache key that has been deleted or [allKeys] if all keys are deleted.
  /// Observers are notified through their [onDelete] method.
  @protected
  void notifyDeleteObservers(String key) {
    if (key == allKeys) {
      // Notify all observers for all keys and then clear the list.
      for (final observer in _observers.values.expand((e) => e)) {
        observer.onDelete(key);
      }
      _observers.clear();
    } else {
      // Notify all observers for the specific key and then remove the key from observers.
      _observers[key]?.forEach((observer) {
        observer.onDelete(key);
      });
      _observers.remove(key);
    }
  }
}
