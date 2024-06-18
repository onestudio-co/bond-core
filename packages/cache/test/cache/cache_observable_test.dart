import 'package:bond_cache/src/cache/bond_cache.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

void main() {
  group('CacheObservable Tests', () {
    late CacheObservableMixin cache;
    setUp(() {
      cache = CacheObservableMixin();
    });

    test('Observers are added correctly', () {
      var key = 'testKey';
      var observer = MockObserver();

      cache.watch(key, observer);

      expect(cache.observers[key]?.containsObserver(observer), isTrue);
    });

    test('Observer limit is enforced', () {
      var key = 'testKey';
      for (var i = 0; i < cache.maxObserversPerKey + 2; i++) {
        var observer = MockObserver();
        cache.watch(key, observer);
      }
      expect(cache.observers[key]?.length, cache.maxObserversPerKey);
    });

    test('Observers are removed correctly', () {
      var key = 'testKey';
      var observer = MockObserver();

      cache.watch(key, observer);
      cache.unwatch(key, observer);
      expect(cache.observers[key]?.contains(observer), isFalse);
    });
  });

  group('CacheObserver Notification Tests', () {
    late CacheObservableMixin cache;
    late MockObserver observer;

    setUp(() {
      cache = CacheObservableMixin();
      observer = MockObserver();
    });

    test('Observer calls onUpdate when notified of a change', () {
      var key = 'testKey';
      var newValue = 'newValue';

      cache.watch(key, observer);
      cache.notifyObservers(key, newValue);

      // Verify that onUpdate was called with the correct key and value
      verify(observer.onUpdate(key, newValue)).called(1);
    });

    test('Observer calls onDelete when a key is deleted', () {
      var key = 'testKey';

      cache.watch(key, observer);
      cache.notifyDeleteObservers(key);

      // Verify that onDelete was called with the correct key
      verify(observer.onDelete(key)).called(1);
    });
  });
}

class CacheObservableMixin
    with CacheObservable {} // Example concrete implementation

class MockObserver<T> extends Mock implements CacheObserver {
  MockObserver();

  @override
  void onDelete(String key) {
    super.noSuchMethod(
      Invocation.method(#onDelete, [key]),
    );
  }

  @override
  void onUpdate(String key, dynamic newValue) {
    super.noSuchMethod(
      Invocation.method(#onUpdate, [key, newValue]),
    );
  }
}
