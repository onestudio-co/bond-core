import 'package:bond_cache/bond_cache.dart';
import 'package:bond_cache/src/helpers/common_cache_helper.dart';
import 'package:mockito/mockito.dart';

class MockCacheDriver extends CacheDriver with Mock {
  @override
  bool has(String? key) => super.noSuchMethod(
        Invocation.method(#has, [key]),
        returnValue: true,
      );

  @override
  Json? retrieve(String? key) => super.noSuchMethod(
        Invocation.method(#retrieve, [key]),
      );

  @override
  Future<bool> store(String? key, Json? data) => super.noSuchMethod(
        Invocation.method(#store, [key, data]),
        returnValue: Future.value(false),
      );

  @override
  Future<bool> forget(String? key) => super.noSuchMethod(
        Invocation.method(#forget, [key]),
        returnValue: Future.value(false),
      );
}
