import 'package:bond_cache/src/cache/bond_cache.dart';
import 'package:bond_core/bond_core.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../common/mock_service_provider.dart';
import 'mock_cache_driver.dart';

void main() {
  late MockCacheDriver _mockDriver;
  late BondCache _cache;

  final _mockedServiceProvider = MockServiceProvider();

  setUp(() {
    appProviders.add(_mockedServiceProvider);
    _mockDriver = MockCacheDriver();
    _cache = BondCache(driver: _mockDriver);
  });

  tearDown(() => appProviders.clear());

  group('flush', () {
    test('returns true when cache is flushed', () async {
      when(_mockDriver.removeAll()).thenAnswer((_) async => true);

      final result = await _cache.flush();
      expect(result, isTrue);
    });

    test('returns false when cache is not flushed', () async {
      when(_mockDriver.removeAll()).thenAnswer((_) async => false);

      final result = await _cache.flush();
      expect(result, isFalse);
    });
  });

  group('has', () {
    test('returns true when key exists', () {
      when(_mockDriver.has(any)).thenReturn(true);

      final result = _cache.has('key');
      expect(result, isTrue);
    });

    test('returns false when key does not exist', () {
      when(_mockDriver.has(any)).thenReturn(false);

      final result = _cache.has('key');
      expect(result, isFalse);
    });
  });
}
