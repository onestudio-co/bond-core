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
            defaultValue: 0,
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
            () => _mockDriver.get<int>('not_existing_key', defaultValue: '42'),
            throwsA(isA<ArgumentError>().having(
              (e) => e.message,
              'message',
              equals(
                  'defaultValue must be of type int or a function returning int'),
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
            () => _mockDriver.get<NotRegisteredModel>('existing_key'),
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
