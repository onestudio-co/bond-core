import 'package:bond_cache/src/cache/bond_cache.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'helpers/mock_observer.dart';

void main() {
  group('CacheObservable Tests', () {
    late CacheObservableMixin cache;
    setUp(() {
      cache = CacheObservableMixin();
    });

    test('Observers are added correctly', () {
      var key = 'test_key';
      var observer = MockObserver();

      cache.watch(key, observer);

      expect(cache.observers[key]?.containsObserver(observer), isTrue);
    });

    test('Observer limit is enforced', () {
      var key = 'test_key';
      for (var i = 0; i < cache.maxObserversPerKey + 2; i++) {
        var observer = MockObserver();
        cache.watch(key, observer);
      }
      expect(cache.observers[key]?.length, cache.maxObserversPerKey);
    });

    test('Observers are removed correctly', () {
      var key = 'test_key';
      var observer = MockObserver();

      cache.watch(key, observer);
      cache.unwatch(key, observer);
      expect(cache.observers[key]?.contains(observer), isFalse);
    });
  });

  group('CacheObserver Notification Tests', () {
    late CacheObservableMixin cache;

    setUp(() {
      cache = CacheObservableMixin();
    });

    test('Observer calls onUpdate when notified of a change', () {
      var key = 'test_key';
      var newValue = 'newValue';
      final observer = MockObserver<String>();

      cache.watch<String>(key, observer);
      cache.notifyObservers(key, newValue);

      // Verify that onUpdate was called with the correct key and value
      verify(observer.onUpdate(key, newValue)).called(1);
    });

    test('Observer calls onDelete when a key is deleted', () {
      var key = 'test_key';

      final observer = MockObserver<String>();

      cache.watch<String>(key, observer);
      cache.notifyDeleteObservers(key);

      // Verify that onDelete was called with the correct key
      verify(observer.onDelete(key)).called(1);
    });
  });
}
