import 'dart:convert';

import 'package:bond_core/bond_core.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../common/mock_service_provider.dart';
import '../common/not_registered_model.dart';
import '../common/registered_model.dart';
import 'mock_cache_driver.dart';

void main() {
  group('CacheDriver', () {
    late MockCacheDriver mockDriver;

    final mockedServiceProvider = MockServiceProvider();

    setUp(() {
      appProviders.add(mockedServiceProvider);
      mockDriver = MockCacheDriver();
    });

    tearDown(() => appProviders.clear());

    group('get', () {
      group('default value', () {
        test('returns defaultValue when key exist but with null value', () {
          when(mockDriver.has(any)).thenReturn(true);
          when(mockDriver.retrieve(any)).thenReturn(null);

          final result = mockDriver.get<int>('existing_key', defaultValue: 42);

          expect(result, equals(42));
        });

        test('returns defaultValue when key does not exist', () {
          when(mockDriver.has(any)).thenReturn(false);

          final result =
              mockDriver.get<int>('nonexistent_key', defaultValue: 42);

          expect(result, equals(42));
        });

        test('returns defaultValue when key exists but is invalid', () {
          final cachedData = '{"data": 42, "expiredAt": 1000}';
          when(mockDriver.has(any)).thenReturn(true);
          when(mockDriver.retrieve(any)).thenReturn(cachedData);
          when(mockDriver.forget('existing_key')).thenAnswer(
            (_) => Future.value(true),
          );

          final result = mockDriver.get<int>('existing_key', defaultValue: 0);

          expect(result, equals(0));
          verify(mockDriver.forget('existing_key')).called(1);
        });

        test('returns defaultValue from function', () {
          when(mockDriver.has(any)).thenReturn(true);
          when(mockDriver.retrieve(any)).thenReturn(null);

          final result = mockDriver.get<int>(
            'existing_key',
            defaultValue: () => 42,
          );

          expect(result, equals(42));
        });

        test('throws ArgumentError for incorrect default value type', () {
          when(mockDriver.has(any)).thenReturn(false);
          expect(
            () => mockDriver.get<int>('not_existing_key', defaultValue: '42'),
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
          final data = 42;
          final cachedData = '{"data": $data, "expiredAt": null}';
          when(mockDriver.has(any)).thenReturn(true);
          when(mockDriver.retrieve(any)).thenReturn(cachedData);

          final result = mockDriver.get<int>('existing_key', defaultValue: 0);

          expect(result, equals(data));
        });

        test('returns cached double value when key exists and is valid', () {
          final data = 42.0;
          final cachedData = '{"data": $data, "expiredAt": null}';
          when(mockDriver.has(any)).thenReturn(true);
          when(mockDriver.retrieve(any)).thenReturn(cachedData);

          final result =
              mockDriver.get<double>('existing_key', defaultValue: 0.0);

          expect(result, equals(data));
        });

        test('returns cached bool value when key exists and is valid', () {
          final data = true;
          final cachedData = '{"data": $data, "expiredAt": null}';
          when(mockDriver.has(any)).thenReturn(true);
          when(mockDriver.retrieve(any)).thenReturn(cachedData);

          final result =
              mockDriver.get<bool>('existing_key', defaultValue: false);

          expect(result, equals(data));
        });

        test('returns cached String value when key exists and is valid', () {
          final data = 'SÜẞ';
          final cachedData = '{"data": "$data", "expiredAt": null}';
          when(mockDriver.has(any)).thenReturn(true);
          when(mockDriver.retrieve(any)).thenReturn(cachedData);

          final result =
              mockDriver.get<String>('existing_key', defaultValue: '');

          expect(result, equals(data));
        });
      });

      group('custom types', () {
        test('returns cached registered type when key exists and is valid', () {
          final json = {'data': 'SÜẞ'};
          final encodedJson = jsonEncode(json);
          final data = RegisteredModel.fromJson(json);
          final cachedData = '{"data": $encodedJson, "expiredAt": null}';
          when(mockDriver.has(any)).thenReturn(true);
          when(mockDriver.retrieve(any)).thenReturn(cachedData);

          final result = mockDriver.get<RegisteredModel>('existing_key');

          expect(result, equals(data));
        });

        test('returns cached provided type when key exists and is valid', () {
          final json = {'data': 'SÜẞ'};
          final encodedJson = jsonEncode(json);
          final data = NotRegisteredModel.fromJson(json);
          final cachedData = '{"data": $encodedJson, "expiredAt": null}';
          when(mockDriver.has(any)).thenReturn(true);
          when(mockDriver.retrieve(any)).thenReturn(cachedData);

          final result = mockDriver.get<NotRegisteredModel>(
            'existing_key',
            fromJsonFactory: NotRegisteredModel.fromJson,
          );

          expect(result, equals(data));
        });

        test('throws an argument error exception for unregistered cached type',
            () {
          final json = {'data': 'SÜẞ'};
          final encodedJson = jsonEncode(json);
          final cachedData = '{"data": $encodedJson, "expiredAt": null}';
          when(mockDriver.has(any)).thenReturn(true);
          when(mockDriver.retrieve(any)).thenReturn(cachedData);

          expect(
            () => mockDriver.get<NotRegisteredModel>('existing_key'),
            throwsA(
              isA<ArgumentError>().having(
                  (e) => e.message,
                  'message',
                  contains(
                      'No ResponseDecoding provider found for type NotRegisteredModel')),
            ),
          );
        });

        test('throws a format exception for unsupported type', () {
          final data = DateTime.timestamp();
          final cachedData = '{"data": ${data.toString()}, "expiredAt": null}';
          when(mockDriver.has(any)).thenReturn(true);
          when(mockDriver.retrieve(any)).thenReturn(cachedData);
          expect(
            () => mockDriver.get<DateTime>('existing_key'),
            throwsA(
              isA<FormatException>().having(
                (e) => e.message,
                'message',
                equals('Could not decode: $cachedData'),
              ),
            ),
          );
        });
      });
    });

    group('put ', () {
      test('stores correct value', () async {
        final key = 'key';
        final data = 42;
        final encodedData = jsonEncode(data);

        when(mockDriver.store(key, encodedData)).thenAnswer(
          (_) => Future.value(true),
        );

        final result = await mockDriver.put<int>(key, 42);

        expect(result, isTrue);
        verify(mockDriver.store(key, encodedData)).called(1);
      });
    });
  });
}
