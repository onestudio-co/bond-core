import 'package:bond_cache/src/cache/bond_cache.dart';
import 'package:bond_core/bond_core.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../common/mock_service_provider.dart';
import 'helpers/mock_cache_driver.dart';

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

  group('forget', () {
    test('returns true when key exists', () async {
      when(_mockDriver.remove(any)).thenAnswer((_) async => true);

      final result = await _cache.forget('key');
      expect(result, isTrue);
    });

    test('returns false when key does not exist', () async {
      when(_mockDriver.remove(any)).thenAnswer((_) async => false);

      final result = await _cache.forget('key');
      expect(result, isFalse);
    });
  });
}
