import 'package:async/async.dart';
import 'package:test/test.dart';

import 'cache_observable_test.dart';

void main() {
  group('Stream method Tests', () {
    late CacheObservableMixin cache;

    setUp(() {
      cache = CacheObservableMixin();
    });

    test('Reuse existing observer stream', () async {
      var key = 'test_key';

      final stream1 = cache.stream<int>(key);
      final stream2 = cache.stream<int>(key);

      // Use StreamQueue to listen to streams
      final queue1 = StreamQueue<int>(stream1);
      final queue2 = StreamQueue<int>(stream2);

      // Simulate an event
      cache.notifyObservers(key, 42);

      // Check that both streams emit the same sequence
      await expectLater(queue1.next, completion(42));
      await expectLater(queue2.next, completion(42));

      await queue1.cancel();
      await queue2.cancel();
    });

    test('Not reuse observers rather than ICacheObserver', () {
      final key = 'test_key';

      cache.watch(key, MockObserver());

      expect(cache.observers[key]?.length, equals(1));

      cache.stream<int>(key);

      expect(cache.observers[key]?.length, equals(2));
    });

    test('Stream emits updates on data change', () async {
      final key = 'test_key';

      final stream = cache.stream<int>(key);
      final streamListener = StreamQueue<int>(stream);

      cache.notifyObservers<int>(key, 42);

      expect(await streamListener.next, 42);
      await streamListener.cancel();
    });

    test('Stream closes on key deletion', () async {
      final key = 'test_key';

      final stream = cache.stream<int>(key);
      final streamListener = StreamQueue<int>(stream);

      cache.notifyObservers<int>(key, 42);
      cache.notifyDeleteObservers(key);
      cache.notifyObservers<int>(key, 44);

      expect(await streamListener.next, 42);
      expect(await streamListener.hasNext, isFalse);

      await streamListener.cancel();
    });

    test('Stream closes on unwatch called', () async {
      final key = 'test_key';

      final stream = cache.stream<int>(key);
      final streamListener = StreamQueue<int>(stream);

      cache.notifyObservers<int>(key, 42);
      cache.unwatch<int>(key, cache.observers[key]!.first);
      cache.notifyObservers<int>(key, 44);

      expect(await streamListener.next, 42);
      expect(await streamListener.hasNext, isFalse);
      await streamListener.cancel();
    });
  });
}
