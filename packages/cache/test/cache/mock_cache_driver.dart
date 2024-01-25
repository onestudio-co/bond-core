import 'package:bond_cache/bond_cache.dart';
import 'package:mockito/mockito.dart';

class MockCacheDriver extends CacheDriver with Mock {
  @override
  bool has(String? key) => super.noSuchMethod(
        Invocation.method(#has, [key]),
        returnValue: true,
      );

  @override
  String? retrieve(String? key) => super.noSuchMethod(
        Invocation.method(#retrieve, [key]),
      );

  @override
  Future<bool> store(String? key, String? data) => super.noSuchMethod(
        Invocation.method(#store, [key, data]),
        returnValue: Future.value(false),
      );

  @override
  Future<bool> forget(String? key) => super.noSuchMethod(
        Invocation.method(#forget, [key]),
        returnValue: Future.value(false),
      );
}
