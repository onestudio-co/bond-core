import 'package:bond_cache/bond_cache.dart';
import 'package:bond_cache/src/cache/bond_cache.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'cache/helpers/mock_observer.dart';

void main() {
  group('Cache Stream and Watch Tests', () {
    setUp(() {
      // Initialize Cache with an in-memory driver or a mock driver
      Cache.cacheDriver = BondCache(driver: InMemoryCacheDriver());
    });

    test('stream emits updates when data changes', () async {
      final key = 'stream_key';
      final stream = Cache.stream<int>(key);
      final results = <int>[];

      // Listen to the stream
      final subscription = stream.listen(results.add);

      // Trigger updates
      await Cache.put<int>(key, 1);
      await Cache.put<int>(key, 2);

      // Wait for all asynchronous operations to complete
      await Future.delayed(const Duration(milliseconds: 100));

      // verify that the stream emitted the updates
      expect(results, [1, 2]);

      await subscription.cancel();
    });

    test('stream still emits after data removed', () async {
      final key = 'stream_key';
      final stream = Cache.stream<int>(key);
      final results = <int>[];
      var streamClosed = false;

      // Listen to the stream
      final subscription = stream.listen(results.add);

      // Trigger an update and then delete
      await Cache.put<int>(key, 1);
      await Cache.forget(key);

      // Wait for all asynchronous operations to complete
      await Future.delayed(const Duration(milliseconds: 100));

      // trigger another update
      await Cache.put<int>(key, 2);

      // Wait for all asynchronous operations to complete
      await Future.delayed(const Duration(milliseconds: 100));

      // verify that the stream emitted the updates
      expect(results, [1, 2]);

      await subscription.cancel();
    });

    test('watch calls onChange when data changes', () async {
      final key = 'watch_key';
      var latestValue = 0;

      // Setup watch
      final observer = MockObserver<int>();
      when(observer.onUpdate(key, any)).thenAnswer((_) {
        latestValue = _.positionalArguments[1] as int;
      });
      Cache.watch<int>(key, observer);

      // Trigger updates
      await Cache.put<int>(key, 1);
      await Cache.put<int>(key, 2);

      // verify that onUpdate was called with the correct values
      expect(latestValue, 2);
      verify(observer.onUpdate(key, any)).called(2);
    });

    test('watch calls on delete when data removed', () async {
      final key = 'watch_key';
      final value = 1;

      /// Setup watch
      await Cache.put<int>(key, value);
      final observer = MockObserver<int>();
      Cache.watch<int>(key, observer);

      // Trigger delete
      await Cache.forget(key);

      // verify that onDelete was called
      verify(observer.onDelete(key)).called(1);
      verifyNever(observer.onUpdate(key, value));
    });

    test('unwatch removes observer', () async {
      final key = 'watch_key';
      final value = 1;

      final observer = MockObserver<int>();

      // Setup watch
      Cache.watch<int>(key, observer);
      await Cache.put<int>(key, value);

      // verify that onUpdate was called
      verify(observer.onUpdate(key, value)).called(1);

      // setup unwatch
      Cache.unwatch<int>(key, observer);
      clearInteractions(observer);

      // Trigger update
      Cache.put<int>(key, value);

      // verify that onUpdate was not called
      verifyNever(observer.onUpdate(key, value));
    });
  });
}
