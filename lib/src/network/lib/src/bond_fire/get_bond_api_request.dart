part of 'base_bond_api_request.dart';

class GetBondApiRequest<T extends Jsonable> extends BaseBondApiRequest<T> {
  Duration? _cacheDuration;
  String? _cacheKey;
  CachePolicy _cachePolicy = CachePolicy.networkOnly;

  GetBondApiRequest(
    Dio dio,
    String path,
  ) : super(dio, path, method: 'GET');

  GetBondApiRequest<T> cache({
    Duration? duration,
    String? cacheKey,
    CachePolicy? cachePolicy,
  }) {
    _cacheDuration = duration ?? _cacheDuration;
    _cacheKey = cacheKey ?? _path;
    _cachePolicy = cachePolicy ?? _cachePolicy;
    return this;
  }

  @override
  GetBondApiRequest<T> cacheCustomKey(String key, {required String path}) {
    _customCacheKeys[key] = path;
    return this;
  }

  // Override the execute method for GET requests and implement caching
  @override
  Future<T> execute() async {
    if (_cacheKey != null) {
      final bool hasCache = await Cache.has(_cacheKey!);
      switch (_cachePolicy) {
        case CachePolicy.cacheElseNetwork:
          if (hasCache) {
            return await Cache.get(_cacheKey!, fromJsonFactory: _factory);
          } else {
            return await _executeAndCache();
          }
        case CachePolicy.networkElseCache:
          try {
            return await _executeAndCache();
          } catch (_) {
            if (hasCache) {
              return await Cache.get(_cacheKey!, fromJsonFactory: _factory);
            }
            rethrow;
          }
        case CachePolicy.networkOnly:
        case CachePolicy.cacheThenNetwork:
          return await _executeAndCache();
      }
    } else {
      return super.execute();
    }
  }

  Stream<T> streamExecute() {
    if (_cachePolicy == CachePolicy.cacheThenNetwork) {
      return _executeCacheThenNetwork();
    } else {
      throw UnsupportedError(
          'Use execute method for cache policies other than cacheThenNetwork');
    }
  }

  Future<T> _executeAndCache() async {
    final result = await super.execute();
    await Cache.put(_cacheKey!, result, expiredAfter: _cacheDuration);
    return result;
  }

  Stream<T> _executeCacheThenNetwork() async* {
    if (_cacheDuration != null && _cacheKey != null) {
      final bool hasCache = await Cache.has(_cacheKey!);
      if (hasCache) {
        yield await Cache.get<T>(_cacheKey!, fromJsonFactory: _factory);
      }
    }
    yield await execute();
  }
}
