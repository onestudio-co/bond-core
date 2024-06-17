import 'package:bond_cache/src/cache/bond_cache.dart';
import 'package:bond_core/bond_core.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../common/custom_object.dart';
import '../common/mock_service_provider.dart';
import '../common/not_registered_model.dart';
import '../common/registered_model.dart';
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

  group('get', () {
    group('default value', () {
      test(
          'returns defaultValue and remove the key'
          ' when key exists but null', () {
        _mockDriver.whenHasThenReturn(
          key: 'existing_key',
          returnValue: true,
        );
        _mockDriver.whenRetrieveThenReturn(
          key: 'existing_key',
          cachedData: {'data': null, 'expiredAt': null},
        );
        _mockDriver.whenRemoveThenAnswer(
          key: 'existing_key',
          answer: true,
        );

        final result = _cache.get<int>(
          'existing_key',
          defaultValue: 42,
        );

        expect(result, equals(42));
        verify(_mockDriver.remove('existing_key')).called(1);
      });

      test('returns defaultValue when key does not exist', () {
        _mockDriver.whenHasThenReturn(
          key: 'not_existing_key',
          returnValue: false,
        );

        final result = _cache.get<int>(
          'not_existing_key',
          defaultValue: 42,
        );

        expect(result, equals(42));
      });

      test(
          'returns defaultValue and remove the key'
          ' when key exists but expired', () {
        _mockDriver.whenHasThenReturn(
          key: 'existing_key',
          returnValue: true,
        );
        _mockDriver.whenRetrieveThenReturn(
          key: 'existing_key',
          cachedData: {'data': 42, 'expiredAt': 1000},
        );
        _mockDriver.whenRemoveThenAnswer(
          key: 'existing_key',
          answer: true,
        );

        final result = _cache.get<int>(
          'existing_key',
          defaultValue: 42,
        );

        expect(result, equals(42));
        verify(_mockDriver.remove('existing_key')).called(1);
      });

      test('returns defaultValue from function', () {
        when(_mockDriver.has(any)).thenReturn(true);
        when(_mockDriver.retrieve(any)).thenReturn(null);

        final result = _cache.get<int>(
          'existing_key',
          defaultValue: () => 42,
        );

        expect(result, equals(42));
      });

      test('throws ArgumentError for incorrect default value type', () {
        when(_mockDriver.has(any)).thenReturn(false);
        expect(
          () => _cache.get<int>('key', defaultValue: '42'),
          throwsA(isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            equals(
                'defaultValue must be of type int or a function returning int'),
          )),
        );
      });

      test('returns null when key does not exist for nullable type', () {
        when(_mockDriver.has(any)).thenReturn(false);
        final result = _cache.get<CustomObject?>('key');
        expect(result, isNull);
      });

      test('throws an error when key does not exist for non-nullable type', () {
        when(_mockDriver.has(any)).thenReturn(false);
        expect(
          () => _cache.get<String>('key'),
          throwsA(isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            contains(
                'defaultValue must be of type String or a function returning String'),
          )),
        );
      });
    });

    group('primitive types', () {
      test('returns cached int value when key exists and is valid', () {
        _mockDriver.whenHasThenReturn(
          key: 'existing_key',
          returnValue: true,
        );
        final data = 42;
        _mockDriver.whenRetrieveThenReturn(
          key: 'existing_key',
          cachedData: {'data': data, 'expiredAt': null},
        );

        final result = _cache.get<int>('existing_key');

        expect(result, equals(data));
      });

      test('returns cached double value when key exists and is valid', () {
        _mockDriver.whenHasThenReturn(
          key: 'existing_key',
          returnValue: true,
        );
        final data = 42.0;
        _mockDriver.whenRetrieveThenReturn(
          key: 'existing_key',
          cachedData: {'data': data, 'expiredAt': null},
        );

        final result = _cache.get<double>('existing_key');

        expect(result, equals(data));
      });

      test('returns cached bool value when key exists and is valid', () {
        _mockDriver.whenHasThenReturn(
          key: 'existing_key',
          returnValue: true,
        );
        final data = true;
        _mockDriver.whenRetrieveThenReturn(
          key: 'existing_key',
          cachedData: {'data': data, 'expiredAt': null},
        );

        final result = _cache.get<bool>('existing_key');

        expect(result, equals(data));
      });

      test('returns cached String value when key exists and is valid', () {
        _mockDriver.whenHasThenReturn(
          key: 'existing_key',
          returnValue: true,
        );
        final data = 'SÜẞ';
        _mockDriver.whenRetrieveThenReturn(
          key: 'existing_key',
          cachedData: {'data': data, 'expiredAt': null},
        );

        final result = _cache.get<String>('existing_key');

        expect(result, equals(data));
      });
    });

    group('custom types', () {
      test('returns cached registered type when key exists and is valid', () {
        final json = {'data': 'SÜẞ'};
        final data = RegisteredModel.fromJson(json);

        _mockDriver.whenHasThenReturn(
          key: 'existing_key',
          returnValue: true,
        );
        _mockDriver.whenRetrieveThenReturn(key: 'existing_key', cachedData: {
          'data': {'data': 'SÜẞ'},
          'expiredAt': null,
        });

        final result = _cache.get<RegisteredModel>('existing_key');

        expect(result, equals(data));
      });

      test('returns cached provided type when key exists and is valid', () {
        final json = {'data': 'SÜẞ'};
        final data = NotRegisteredModel.fromJson(json);

        _mockDriver.whenHasThenReturn(
          key: 'existing_key',
          returnValue: true,
        );
        _mockDriver.whenRetrieveThenReturn(key: 'existing_key', cachedData: {
          'data': {'data': 'SÜẞ'},
          'expiredAt': null,
        });

        final result = _cache.get<NotRegisteredModel>(
          'existing_key',
          fromJsonFactory: NotRegisteredModel.fromJson,
        );

        expect(result, equals(data));
      });

      test('throws an argument error exception for unregistered cached type',
          () {
        final json = {'data': 'SÜẞ'};
        final cachedData = {'data': json, 'expiredAt': null};
        _mockDriver.whenHasThenReturn(
          key: 'existing_key',
          returnValue: true,
        );
        _mockDriver.whenRetrieveThenReturn(
          key: 'existing_key',
          cachedData: cachedData,
        );

        expect(
          () => _cache.get<NotRegisteredModel>('existing_key'),
          throwsA(
            isA<ArgumentError>().having(
              (e) => e.message,
              'message',
              contains(
                  'No ResponseDecoding provider found for type NotRegisteredModel'),
            ),
          ),
        );
      });
    });
  });

  group('get all', () {
    group('default value', () {
      test(
          'returns defaultValue and remove the key'
          ' when key exists but null', () {
        _mockDriver.whenHasThenReturn(
          key: 'existing_key',
          returnValue: true,
        );
        _mockDriver.whenRetrieveThenReturn(
          key: 'existing_key',
          cachedData: {'data': null, 'expiredAt': null},
        );
        _mockDriver.whenRemoveThenAnswer(
          key: 'existing_key',
          answer: true,
        );

        final result = _cache.getAll<int>(
          'existing_key',
          defaultValue: [42],
        );

        expect(result, equals([42]));
        verify(_mockDriver.remove('existing_key')).called(1);
      });

      test('returns defaultValue when key does not exist', () {
        _mockDriver.whenHasThenReturn(
          key: 'not_existing_key',
          returnValue: false,
        );

        final result = _cache.getAll<int>(
          'not_existing_key',
          defaultValue: [42],
        );

        expect(result, equals([42]));
      });

      test(
          'returns defaultValue and remove the key'
          ' when key exists but expired', () {
        _mockDriver.whenHasThenReturn(
          key: 'existing_key',
          returnValue: true,
        );
        _mockDriver.whenRetrieveThenReturn(
          key: 'existing_key',
          cachedData: {'data': 42, 'expiredAt': 1000},
        );
        _mockDriver.whenRemoveThenAnswer(
          key: 'existing_key',
          answer: true,
        );

        final result = _cache.getAll<int>(
          'existing_key',
          defaultValue: [42],
        );

        expect(result, equals([42]));
        verify(_mockDriver.remove('existing_key')).called(1);
      });

      test('returns defaultValue from function', () {
        _mockDriver.whenHasThenReturn(returnValue: true);
        _mockDriver.whenRetrieveThenReturn(cachedData: null);

        final result = _cache.getAll<int>(
          'existing_key',
          defaultValue: () => [42],
        );

        expect(result, equals([42]));
      });

      test('throws ArgumentError for incorrect default value type', () {
        _mockDriver.whenHasThenReturn(
          returnValue: false,
        );
        expect(
          () => _cache.getAll<int>('key', defaultValue: ['42']),
          throwsA(isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            equals(
                'defaultValue must be of type List<int> or a function returning List<int>'),
          )),
        );
      });
    });

    group('primitive types', () {
      test('returns cached int value when key exists and is valid', () {
        _mockDriver.whenHasThenReturn(
          key: 'existing_key',
          returnValue: true,
        );
        final data = [42, 44];
        _mockDriver.whenRetrieveThenReturn(
          key: 'existing_key',
          cachedData: {'data': data, 'expiredAt': null},
        );

        final result = _cache.getAll<int>('existing_key');

        expect(result, equals(data));
      });

      test('returns cached double value when key exists and is valid', () {
        _mockDriver.whenHasThenReturn(
          key: 'existing_key',
          returnValue: true,
        );
        final data = [42.0, 44.0];
        _mockDriver.whenRetrieveThenReturn(
          key: 'existing_key',
          cachedData: {'data': data, 'expiredAt': null},
        );

        final result = _cache.getAll<double>('existing_key');

        expect(result, equals(data));
      });

      test('returns cached bool value when key exists and is valid', () {
        _mockDriver.whenHasThenReturn(
          key: 'existing_key',
          returnValue: true,
        );
        final data = [true, false];
        _mockDriver.whenRetrieveThenReturn(
          key: 'existing_key',
          cachedData: {'data': data, 'expiredAt': null},
        );

        final result = _cache.getAll<bool>('existing_key');

        expect(result, equals(data));
      });

      test('returns cached String value when key exists and is valid', () {
        _mockDriver.whenHasThenReturn(
          key: 'existing_key',
          returnValue: true,
        );
        final data = ['SÜẞ', 'NB'];
        _mockDriver.whenRetrieveThenReturn(
          key: 'existing_key',
          cachedData: {'data': data, 'expiredAt': null},
        );

        final result = _cache.getAll<String>('existing_key');

        expect(result, equals(data));
      });
    });

    group('custom types', () {
      test('returns cached registered type when key exists and is valid', () {
        final json = {'data': 'SÜẞ'};
        final json2 = {'data': 'NB'};
        final data = [
          RegisteredModel.fromJson(json),
          RegisteredModel.fromJson(json2),
        ];
        _mockDriver.whenHasThenReturn(
          key: 'existing_key',
          returnValue: true,
        );
        _mockDriver.whenRetrieveThenReturn(
          key: 'existing_key',
          cachedData: {
            'data': [json, json2],
            'expiredAt': null,
          },
        );

        final result = _cache.getAll<RegisteredModel>('existing_key');

        expect(result, equals(data));
      });

      test('returns cached provided type when key exists and is valid', () {
        final json = {'data': 'SÜẞ'};
        final json2 = {'data': 'NB'};
        final data = [
          NotRegisteredModel.fromJson(json),
          NotRegisteredModel.fromJson(json2),
        ];
        _mockDriver.whenHasThenReturn(
          key: 'existing_key',
          returnValue: true,
        );
        _mockDriver.whenRetrieveThenReturn(
          key: 'existing_key',
          cachedData: {
            'data': [json, json2],
            'expiredAt': null,
          },
        );

        final result = _cache.getAll<NotRegisteredModel>(
          'existing_key',
          fromJsonFactory: NotRegisteredModel.fromJson,
        );

        expect(result, equals(data));
      });

      test('throws an argument error exception for unregistered cached type',
          () {
        final json = {'data': 'SÜẞ'};
        final json2 = {'data': 'NB'};
        final cachedData = {
          'data': [json, json2],
          'expiredAt': null
        };
        _mockDriver.whenHasThenReturn(
          key: 'existing_key',
          returnValue: true,
        );
        _mockDriver.whenRetrieveThenReturn(
          key: 'existing_key',
          cachedData: cachedData,
        );

        expect(
          () => _cache.getAll<NotRegisteredModel>('existing_key'),
          throwsA(
            isA<ArgumentError>().having(
                (e) => e.message,
                'message',
                contains(
                    'No ResponseDecoding provider found for type NotRegisteredModel')),
          ),
        );
      });
    });
  });
}
