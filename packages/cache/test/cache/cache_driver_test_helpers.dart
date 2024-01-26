part of 'cache_driver_test.dart';

late MockCacheDriver _mockDriver;

final _mockedServiceProvider = MockServiceProvider();

void _testGetWithDefaultValue<T>({
  required T defaultValue,
  required T? value,
  bool isInvalid = false,
}) {
  final cachedData = isInvalid
      ? {'data': value, 'expiredAt': 1000}
      : {'data': value, 'expiredAt': null};
  when(_mockDriver.has(any)).thenReturn(true);
  when(_mockDriver.retrieve(any)).thenReturn(isInvalid ? cachedData : null);
  when(_mockDriver.forget('existing_key')).thenAnswer(
    (_) => Future.value(true),
  );

  final result = _mockDriver.get<T>(
    'existing_key',
    defaultValue: isInvalid ? 0 : defaultValue,
  );

  expect(result, equals(isInvalid ? 0 : defaultValue));
  if (isInvalid) {
    verify(_mockDriver.forget('existing_key')).called(1);
  }
}

void _testGet<T>(T data, {T? defaultValue, Factory<T>? fromJsonFactory}) {
  final cachedData = {
    'data': jsonDecode(jsonEncode(data)),
    'expiredAt': null,
  };
  when(_mockDriver.has(any)).thenReturn(true);
  when(_mockDriver.retrieve(any)).thenReturn(cachedData);

  final result = _mockDriver.get<T>(
    'existing_key',
    defaultValue: defaultValue,
    fromJsonFactory: fromJsonFactory,
  );

  expect(result, equals(data));
}

Future<void> _testPut<T>(T value) async {
  final key = 'key';
  final data = {
    'data': jsonDecode(jsonEncode(value)),
    'expiredAt': null,
  };

  when(_mockDriver.store(key, data)).thenAnswer(
        (_) => Future.value(true),
  );

  final result = await _mockDriver.put<T>(key, value);

  expect(result, isTrue);
  verify(_mockDriver.store(key, data)).called(1);
}

Future<void> _testPutAll<T>(List<T> value) async {
  final key = 'key';
  final data = {
    'data': jsonDecode(jsonEncode(value)),
    'expiredAt': null,
  };

  when(_mockDriver.store(key, data)).thenAnswer(
    (_) => Future.value(true),
  );

  final result = await _mockDriver.putAll<T>(key, value);

  expect(result, isTrue);
  verify(_mockDriver.store(key, data)).called(1);
}
