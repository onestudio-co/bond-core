import 'dart:convert';

import 'package:bond_cache/src/helpers/common_cache_helper.dart';
import 'package:bond_core/bond_core.dart';
import 'package:test/test.dart';

import 'helpers/fake_jsonable.dart';
import 'helpers/mock_service_provider.dart';
import 'helpers/not_registered_model.dart';
import 'helpers/registered_model.dart';

void main() {
  group('convertToCacheValue', () {
    test('Check for Jsonable', () {
      final jsonable = FakeJsonable();
      final result = CommonCacheHelper.convertToCacheValue(jsonable);
      expect(result, equals(jsonEncode(jsonable.toJson())));
    });

    test('Check for List<Jsonable>', () {
      final list = [FakeJsonable(), FakeJsonable()];
      final result = CommonCacheHelper.convertToCacheValue(list);
      expect(result, equals(jsonEncode(list.map((e) => e.toJson()).toList())));
    });

    test('Check for int', () {
      final result = CommonCacheHelper.convertToCacheValue(42);
      expect(result, equals('42'));
    });

    test('Check for double', () {
      final result = CommonCacheHelper.convertToCacheValue(42.0);
      expect(result, equals('42.0'));
    });

    test('Check for String', () {
      final result = CommonCacheHelper.convertToCacheValue('hello');
      expect(result, equals('"hello"'));
    });

    test('Check for bool', () {
      final result = CommonCacheHelper.convertToCacheValue(true);
      expect(result, equals('true'));
    });

    test('Check for List<int>', () {
      final list = [1, 2, 3];
      final result = CommonCacheHelper.convertToCacheValue(list);
      expect(result, equals(jsonEncode(list)));
    });

    test('Check for List<double>', () {
      final list = [1.1, 2.2, 3.3];
      final result = CommonCacheHelper.convertToCacheValue(list);
      expect(result, equals(jsonEncode(list)));
    });

    test('Check for List<String>', () {
      final list = ['one', 'two', 'three'];
      final result = CommonCacheHelper.convertToCacheValue(list);
      expect(result, equals(jsonEncode(list)));
    });

    test('Check for List<bool>', () {
      final list = [true, false, true];
      final result = CommonCacheHelper.convertToCacheValue(list);
      expect(result, equals(jsonEncode(list)));
    });

    test('Check for unsupported type', () {
      expect(
        () => CommonCacheHelper.convertToCacheValue(DateTime.now()),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('checkCachedData', () {
    final mockedServiceProvider = MockServiceProvider();

    setUp(() => appProviders.add(mockedServiceProvider));

    tearDown(() => appProviders.clear());

    test('Check for int type', () {
      final result = CommonCacheHelper.checkCachedData<int>(42);
      expect(result, equals(42));
    });

    test('Check for list of int type', () {
      final result = CommonCacheHelper.checkCachedData<List<int>>([42, 45]);
      expect(result, equals([42, 45]));
    });

    test('Check for double type', () {
      final result = CommonCacheHelper.checkCachedData<double>(42.1);
      expect(result, equals(42.1));
    });

    test('Check for list of double type', () {
      final result =
          CommonCacheHelper.checkCachedData<List<double>>([42.1, 45.2]);
      expect(result, equals([42.1, 45.2]));
    });

    test('Check for bool type', () {
      final result = CommonCacheHelper.checkCachedData<bool>(true);
      expect(result, equals(true));
    });

    test('Check for list of bool type', () {
      final result =
          CommonCacheHelper.checkCachedData<List<bool>>([true, false]);
      expect(result, equals([true, false]));
    });

    test('Check for String type', () {
      final result = CommonCacheHelper.checkCachedData<String>('SÜẞ');
      expect(result, equals('SÜẞ'));
    });

    test('Check for list of String type', () {
      final result =
          CommonCacheHelper.checkCachedData<List<String>>(['SÜẞ', 'NB']);
      expect(result, equals(['SÜẞ', 'NB']));
    });

    test('Check for provided factory', () {
      final json = {'data': 'any data'};
      final model = NotRegisteredModel.fromJson(json);
      final result = CommonCacheHelper.checkCachedData<NotRegisteredModel>(
        json,
        fromJsonFactory: NotRegisteredModel.fromJson,
      );
      expect(result, equals(model));
    });

    test('Check for registered type', () {
      final json = {'data': 'any data'};
      final model = RegisteredModel.fromJson(json);
      final result = CommonCacheHelper.checkCachedData<RegisteredModel>(json);
      expect(result, equals(model));
    });

    test(
        'Check for unregistered ResponseDecoding provider and '
        'not provided factory', () {
      final json = {'data': 'any data'};

      expect(
        () => CommonCacheHelper.checkCachedData<NotRegisteredModel>(json),
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

  group('checkDefaultValue', () {
    test('checkDefaultValue returns the value if it matches the type', () {
      final defaultValue = 42;
      final result = CommonCacheHelper.checkDefaultValue<int>(defaultValue);
      expect(result, equals(defaultValue));
    });

    test('checkDefaultValue returns the value from a function', () {
      final defaultValueFunction = () => 42;
      final result =
          CommonCacheHelper.checkDefaultValue<int>(defaultValueFunction);
      expect(result, equals(defaultValueFunction()));
    });

    test('checkDefaultValue throws ArgumentError for incorrect type', () {
      final defaultValue = 'hello';
      expect(
        () => CommonCacheHelper.checkDefaultValue<int>(defaultValue),
        throwsA(isA<ArgumentError>().having(
          (e) => e.message,
          'message',
          contains(
              'defaultValue must be of type int or a function returning int'),
        )),
      );
    });

    test(
        'checkDefaultValue throws ArgumentError for incorrect function return type',
        () {
      final defaultValueFunction = () => 'hello';
      expect(
        () => CommonCacheHelper.checkDefaultValue<int>(defaultValueFunction),
        throwsA(isA<ArgumentError>().having(
          (e) => e.message,
          'message',
          contains(
              'defaultValue must be of type int or a function returning int'),
        )),
      );
    });
  });
}
