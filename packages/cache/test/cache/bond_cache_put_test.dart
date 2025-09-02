import 'package:bond_cache/src/cache/bond_cache.dart';
import 'package:bond_core/bond_core.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../common/custom_object.dart';
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

  group('put ', () {
    test('returns true when storing int value', () async {
      _mockDriver.whenStoreThenAnswer<int>(
        key: 'int_key',
        value: 42,
        answer: true,
      );
      final result = await _cache.put<int>('int_key', 42);

      expect(result, isTrue);
      verify(_mockDriver.store('int_key', {
        'data': 42,
        'expiredAt': null,
      })).called(1);
    });

    test('returns true when storing double value', () async {
      _mockDriver.whenStoreThenAnswer<double>(
        key: 'double_key',
        value: 42.0,
        answer: true,
      );

      final result = await _cache.put<double>('double_key', 42.0);

      expect(result, isTrue);
      verify(_mockDriver.store('double_key', {
        'data': 42.0,
        'expiredAt': null,
      })).called(1);
    });

    test('returns true when storing bool value', () async {
      _mockDriver.whenStoreThenAnswer<bool>(
        key: 'bool_key',
        value: true,
        answer: true,
      );

      final result = await _cache.put<bool>('bool_key', true);

      expect(result, isTrue);
      verify(_mockDriver.store('bool_key', {
        'data': true,
        'expiredAt': null,
      })).called(1);
    });

    test('returns true when storing String value', () async {
      _mockDriver.whenStoreThenAnswer<String>(
        key: 'string_key',
        value: 'SALAH',
        answer: true,
      );

      final result = await _cache.put<String>('string_key', 'SALAH');

      expect(result, isTrue);
      verify(_mockDriver.store('string_key', {
        'data': 'SALAH',
        'expiredAt': null,
      })).called(1);
    });

    test('returns true when storing Custom Object value', () async {
      _mockDriver.whenStoreThenAnswer<CustomObject>(
        key: 'custom_object_key',
        value: CustomObject(),
        answer: true,
      );

      final result = await _cache.put<CustomObject>(
        'custom_object_key',
        CustomObject(),
      );

      expect(result, isTrue);
      verify(_mockDriver.store('custom_object_key', {
        'data': CustomObject().toJson(),
        'expiredAt': null,
      })).called(1);
    });

    test('throws Argument Error when storing Unsupported type', () async {
      final key = 'key';
      final data = DateTime.timestamp();

      expect(
        () async => await _cache.put<DateTime>(key, data),
        throwsA(isA<ArgumentError>()),
      );
      verifyNever(_mockDriver.store(key, any));
    });
  });

  group('put all', () {
    test('returns true when storing List<int> value', () async {
      _mockDriver.whenStoreThenAnswer<List<int>>(
        key: 'int_key',
        value: [42, 44],
        answer: true,
      );

      final result = await _cache.putAll<int>('int_key', [42, 44]);

      expect(result, isTrue);
      verify(_mockDriver.store('int_key', {
        'data': [42, 44],
        'expiredAt': null,
      })).called(1);
    });

    test('returns true when storing List<double> value', () async {
      _mockDriver.whenStoreThenAnswer<List<double>>(
        key: 'double_key',
        value: [42.0, 44.0],
        answer: true,
      );

      final result = await _cache.putAll<double>('double_key', [42.0, 44.0]);

      expect(result, isTrue);
      verify(_mockDriver.store('double_key', {
        'data': [42.0, 44.0],
        'expiredAt': null,
      })).called(1);
    });

    test('returns true when storing List<bool> value', () async {
      _mockDriver.whenStoreThenAnswer<List<bool>>(
        key: 'bool_key',
        value: [true, false],
        answer: true,
      );

      final result = await _cache.putAll<bool>('bool_key', [true, false]);

      expect(result, isTrue);
      verify(_mockDriver.store('bool_key', {
        'data': [true, false],
        'expiredAt': null,
      })).called(1);
    });

    test('returns true when storing List<String> value', () async {
      _mockDriver.whenStoreThenAnswer<List<String>>(
        key: 'string_key',
        value: ['SALAH', 'NB'],
        answer: true,
      );

      final result = await _cache.putAll<String>('string_key', ['SALAH', 'NB']);

      expect(result, isTrue);
      verify(_mockDriver.store('string_key', {
        'data': ['SALAH', 'NB'],
        'expiredAt': null,
      })).called(1);
    });

    test('returns true when storing List<CustomObject> value', () async {
      _mockDriver.whenStoreThenAnswer<List<CustomObject>>(
        key: 'custom_object_key',
        value: [CustomObject(), CustomObject()],
        answer: true,
      );

      final result = await _cache.putAll<CustomObject>(
        'custom_object_key',
        [CustomObject(), CustomObject()],
      );

      expect(result, isTrue);
      verify(_mockDriver.store('custom_object_key', {
        'data': [CustomObject().toJson(), CustomObject().toJson()],
        'expiredAt': null,
      })).called(1);
    });

    test('throws Argument Error when storing Unsupported type', () async {
      final key = 'key';
      final data = [DateTime.timestamp(), DateTime.now()];

      expect(
        () async => await _cache.putAll<DateTime>(key, data),
        throwsA(isA<ArgumentError>()),
      );
      verifyNever(_mockDriver.store(key, any));
    });
  });
}
