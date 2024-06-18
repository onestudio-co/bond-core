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
  @internal
  @visibleForTesting
  final Map<String, List<CacheObserver>> observers = {};

  /// Maximum number of observers per key.
  final int maxObserversPerKey = 5;

  /// A constant for representing notifications for all keys.
  static const String allKeys = '*';

  /// Adds an observer for a specific cache key.
  ///
  /// - Parameters:
  ///   -[key] The cache key to watch.
  ///   -[observer] The observer that will be notified when the key is updated or deleted.
  void watch(String key, CacheObserver observer) {
    observers.putIfAbsent(key, () => []);
    if (observers[key]!.length >= maxObserversPerKey) {
      observers[key]!
          .removeAt(0); // Remove the oldest observer to maintain the limit
    }
    observers[key]!.add(ObserverWrapper(observer, key));
  }

  /// Returns a [Stream] that emits values when a specific cache key is updated.
  ///
  /// - Parameters:
  ///  - [key] The cache key to watch.
  ///  - Returns: A [Stream] that emits values of type [T] when the key is updated.
  ///  If the value stored in the cache is not of type [T], an error is emitted.
  ///  If the key is deleted, the stream is closed.
  Stream<T> stream<T>(String key) {
    final mObservers = observers[key];
    if (mObservers != null) {
      for (final observer in mObservers.whereType<ObserverWrapper>()) {
        if (observer.observer is ICacheObserver<T>) {
          final iObserver = observer.observer as ICacheObserver<T>;
          return iObserver.controller.stream;
        }
      }
    }
    // No existing observer of the correct type was found, create a new one
    final controller = StreamController<T>.broadcast();
    final observer = ICacheObserver<T>(
      controller,
      onUpdate: (String key, T value) {
        controller.add(value);
      },
      onDelete: (String key) {
        controller.close();
      },
    );
    watch(key, observer);
    return controller.stream;
  }

  /// Removes an observer for a specific cache key.
  ///
  /// - Parameters:
  ///   - [key] The cache key the observer is watching.
  ///   - [observer] The observer to remove.
  /// If all observers for a key are removed, the key entry is also removed from the observers map.
  void unwatch<T>(String key, CacheObserver observer) {
    observers[key]?.remove(observer);
    if (observers[key]?.isEmpty ?? true) {
      observers.remove(key);
    }
  }

  /// Notifies all observers watching a specific key about a change.
  ///
  /// - Parameters:
  ///   - [key] The cache key that has been updated.
  ///   - [newValue] The new value of the key after the update.
  /// Each observer's [onUpdate] method is called with the new value.
  @protected
  @visibleForTesting
  void notifyObservers<T>(String key, T newValue) {
    observers[key]?.forEach((observer) {
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
  @visibleForTesting
  void notifyDeleteObservers(String key) {
    if (key == allKeys) {
      // Notify all observers for all keys and then clear the list.
      for (final observer in observers.values.expand((e) => e)) {
        observer.onDelete(key);
      }
      observers.clear();
    } else {
      // Notify all observers for the specific key and then remove the key from observers.
      observers[key]?.forEach((observer) {
        observer.onDelete(key);
      });
      observers.remove(key);
    }
  }
}
