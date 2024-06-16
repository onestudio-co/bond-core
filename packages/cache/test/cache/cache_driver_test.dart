import 'dart:convert';

import 'package:bond_cache/src/helpers/common_cache_helper.dart';
import 'package:bond_core/bond_core.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../common/custom_object.dart';
import '../common/mock_service_provider.dart';
import '../common/not_registered_model.dart';
import '../common/registered_model.dart';
import 'mock_cache_driver.dart';

part 'cache_driver_test_helpers.dart';

class User {
  final String name;
  final int age;

  User(this.name, this.age);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(json['name'], json['age']);
  }

  Map<String, dynamic> toJson() => {'name': name, 'age': age};
}

void main() {
  group('CacheDriver', () {
    setUp(() {
      appProviders.add(_mockedServiceProvider);
      _mockDriver = MockCacheDriver();
    });

    tearDown(() => appProviders.clear());

    group('get', () {
      group('default value', () {
        test('returns defaultValue when key exists but with null value', () {
          _testGetWithDefaultValue<int>(defaultValue: 42, value: null);
        });

        test('returns defaultValue when key does not exist', () {
          _testGetWithDefaultValue<int>(defaultValue: 42, value: null);
        });

        test('returns defaultValue when key exists but is invalid', () {
          _testGetWithDefaultValue<int>(
            defaultValue: 3,
            value: 42,
            isInvalid: true,
          );
        });

        test('returns defaultValue from function', () {
          when(_mockDriver.has(any)).thenReturn(true);
          when(_mockDriver.retrieve(any)).thenReturn(null);

          final result = _mockDriver.get<int>(
            'existing_key',
            defaultValue: () => 42,
          );

          expect(result, equals(42));
        });

        test('throws ArgumentError for incorrect default value type', () {
          when(_mockDriver.has(any)).thenReturn(false);
          expect(
            () => _mockDriver.get<int>('key', defaultValue: '42'),
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
          final result = _mockDriver.get<User?>('key');
          expect(result, isNull);
        });

        test('throws an error when key does not exist for non-nullable type',
            () {
          when(_mockDriver.has(any)).thenReturn(false);
          expect(
            () => _mockDriver.get<String>('key'),
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
          _testGet<int>(42, defaultValue: 0);
        });

        test('returns cached double value when key exists and is valid', () {
          _testGet<double>(42.0, defaultValue: 0.0);
        });

        test('returns cached bool value when key exists and is valid', () {
          _testGet<bool>(true, defaultValue: false);
        });

        test('returns cached String value when key exists and is valid', () {
          _testGet<String>('SÜẞ', defaultValue: null);
        });
      });

      group('custom types', () {
        test('returns cached registered type when key exists and is valid', () {
          final json = {'data': 'SÜẞ'};
          final data = RegisteredModel.fromJson(json);
          _testGet<RegisteredModel>(data, defaultValue: null);
        });

        test('returns cached provided type when key exists and is valid', () {
          final json = {'data': 'SÜẞ'};
          final data = NotRegisteredModel.fromJson(json);
          _testGet<NotRegisteredModel>(
            data,
            defaultValue: null,
            fromJsonFactory: NotRegisteredModel.fromJson,
          );
        });

        test('throws an argument error exception for unregistered cached type',
            () {
          final json = {'data': 'SÜẞ'};
          final cachedData = {'data': json, 'expiredAt': null};
          when(_mockDriver.has(any)).thenReturn(true);
          when(_mockDriver.retrieve(any)).thenReturn(cachedData);

          expect(
            () => _mockDriver.get<NotRegisteredModel>('key'),
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

      test('handle expiredAfter correctly', () {
        _testGet<String>(
          'SÜẞ',
          expiredAfter: Duration(seconds: 2),
          defaultValue: null,
        );
      });
    });

    group('get all', () {
      group('default value', () {
        test('returns defaultValue when key exists but with null value', () {
          _testGetAllWithDefaultValue<int>(defaultValue: [42, 44], value: null);
        });

        test('returns defaultValue when key does not exist', () {
          _testGetAllWithDefaultValue<int>(defaultValue: [42, 44], value: null);
        });

        test('returns defaultValue when key exists but is invalid', () {
          _testGetAllWithDefaultValue<int>(
            defaultValue: [1],
            value: [42],
            isInvalid: true,
          );
        });

        test('returns defaultValue from function', () {
          when(_mockDriver.has(any)).thenReturn(true);
          when(_mockDriver.retrieve(any)).thenReturn(null);

          final result = _mockDriver.getAll<int>(
            'existing_key',
            defaultValue: () => [42],
          );

          expect(result, equals([42]));
        });

        test('throws ArgumentError for incorrect default value type', () {
          when(_mockDriver.has(any)).thenReturn(false);
          expect(
            () => _mockDriver.getAll<int>('key', defaultValue: ['42']),
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
          _testGetAll<int>([42, 44], defaultValue: [0]);
        });

        test('returns cached double value when key exists and is valid', () {
          _testGetAll<double>([42.0, 44.0], defaultValue: [0.0]);
        });

        test('returns cached bool value when key exists and is valid', () {
          _testGetAll<bool>([true, false], defaultValue: [false]);
        });

        test('returns cached String value when key exists and is valid', () {
          _testGetAll<String>(['SÜẞ', 'NB'], defaultValue: null);
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
          _testGetAll<RegisteredModel>(data, defaultValue: null);
        });

        test('returns cached provided type when key exists and is valid', () {
          final json = {'data': 'SÜẞ'};
          final json2 = {'data': 'NB'};
          final data = [
            NotRegisteredModel.fromJson(json),
            NotRegisteredModel.fromJson(json2),
          ];
          _testGetAll<NotRegisteredModel>(
            data,
            defaultValue: null,
            fromJsonFactory: NotRegisteredModel.fromJson,
          );
        });

        test('throws an argument error exception for unregistered cached type',
            () {
          final json = {'data': 'SÜẞ'};
          final json2 = {'data': 'NB'};
          final cachedData = {
            'data': [json, json2],
            'expiredAt': null
          };
          when(_mockDriver.has(any)).thenReturn(true);
          when(_mockDriver.retrieve(any)).thenReturn(cachedData);

          expect(
            () => _mockDriver.getAll<NotRegisteredModel>('key'),
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

      test('handle expiredAfter correctly', () {
        _testGetAll<String>(
          ['SÜẞ', 'NB'],
          expiredAfter: Duration(seconds: 10),
          defaultValue: null,
        );
      });
    });

    group('put ', () {
      test('returns true when storing int value', () async {
        await _testPut<int>(42);
      });

      test('returns true when storing double value', () async {
        await _testPut<double>(42.0);
      });

      test('returns true when storing bool value', () async {
        await _testPut<bool>(true);
      });

      test('returns true when storing String value', () async {
        await _testPut<String>('SÜẞ');
      });

      test('returns true when storing Custom Object value', () async {
        await _testPut<CustomObject>(CustomObject());
      });

      test('throws Argument Error when storing Unsupported type', () async {
        final key = 'key';
        final data = DateTime.timestamp();

        expect(
          () async => await _mockDriver.put<DateTime>(key, data),
          throwsA(isA<ArgumentError>()),
        );
        verifyNever(_mockDriver.store(key, any));
      });
    });

    group('put all', () {
      test('returns true when storing List<int> value', () async {
        await _testPutAll<int>([42, 44]);
      });

      test('returns true when storing List<double> value', () async {
        await _testPutAll<double>([42.0, 44.0]);
      });

      test('returns true when storing List<bool> value', () async {
        await _testPutAll<bool>([true, false]);
      });

      test('returns true when storing List<String> value', () async {
        await _testPutAll<String>(['SÜẞ', 'One']);
      });

      test('returns true when storing List<CustomObject> value', () async {
        await _testPutAll<CustomObject>([CustomObject(), CustomObject()]);
      });

      test('throws Argument Error when storing Unsupported type', () async {
        final key = 'key';
        final data = [DateTime.timestamp(), DateTime.now()];

        expect(
          () async => await _mockDriver.putAll<DateTime>(key, data),
          throwsA(isA<ArgumentError>()),
        );
        verifyNever(_mockDriver.store(key, any));
      });
    });
  });
}
