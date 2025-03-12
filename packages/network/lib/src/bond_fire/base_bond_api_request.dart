import 'dart:convert';
import 'dart:io';

import 'package:bond_cache/bond_cache.dart';
import 'package:bond_core/bond_core.dart';
import 'package:dio/dio.dart';

part 'cache_policy.dart';

part 'get_bond_api_request.dart';

/// BondApiRequest allows you to configure an API request
/// by chaining methods for headers, query parameters, body, etc.

typedef Factory<T> = T Function(Map<String, dynamic>);
typedef ErrorFactory<T extends Error> = T Function(Map<String, dynamic>);

class BaseBondApiRequest<T> {
  final Dio _dio;
  final String _path;
  final String _method;

  Map<String, String> _headers = <String, String>{};
  Map<String, dynamic> _queryParameters = <String, dynamic>{};
  Map<String, dynamic>? _body;
  Map<String, File>? _files;
  Map<String, dynamic>? _data;
  CancelToken? _cancelToken;
  Factory<T>? _factory;
  ErrorFactory? _errorFactory;
  final Map<String, String> _customCacheKeys = {};

  BaseBondApiRequest(
    this._dio,
    String path, {
    required String method,
  })  : _path = path,
        _method = method;

  BaseBondApiRequest<T> header(Map<String, String> headers) {
    _headers = headers;
    return this;
  }

  BaseBondApiRequest<T> queryParameters(Map<String, dynamic> queryParameters) {
    _queryParameters = queryParameters;
    return this;
  }

  BaseBondApiRequest<T> body(Map<String, dynamic> body) {
    _body = body;
    return this;
  }

  BaseBondApiRequest<T> files(Map<String, File> files) {
    _files = files;
    return this;
  }

  BaseBondApiRequest<T> data(Map<String, dynamic> data) {
    _data = data;
    return this;
  }

  BaseBondApiRequest<T> cancelToken(CancelToken cancelToken) {
    _cancelToken = cancelToken;
    return this;
  }

  BaseBondApiRequest<T> factory(Factory<T> factory) {
    _factory = factory;
    return this;
  }

  BaseBondApiRequest<T> errorFactory(ErrorFactory errorFactory) {
    _errorFactory = errorFactory;
    return this;
  }

  BaseBondApiRequest<T> cacheCustomKey(String key, {required String path}) {
    _customCacheKeys[key] = path;
    return this;
  }

  Future<T> execute() async {
    // Perform the request using _dio and handle the response
    // Convert the response JSON to the desired model using the provided factory method, error handler, etc.
    try {
      final data = await _getRequestData();
      final response = await _dio.request(
        _path,
        queryParameters: _queryParameters,
        data: data,
        options: Options(
          method: _method,
          headers: _headers,
        ),
        cancelToken: _cancelToken,
      );
      if (_customCacheKeys.entries.isNotEmpty) {
        await _cacheCustomKeys(response.data);
      }
      if (_factory != null) {
        return _factory!(response.data);
      } else {
        return response.data;
      }
    } on DioException catch (error) {
      if (_errorFactory != null && error.response != null) {
        final data = error.response!.data;
        if (data is Map<String, dynamic>) {
          throw _errorFactory!(data);
        } else if (data is String) {
          throw _errorFactory!(jsonDecode(data));
        } else {
          rethrow;
        }
      }
      rethrow;
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> _getRequestData() async {
    if (_files != null && _files!.isNotEmpty) {
      final formData = await _createFormData(files: _files!, data: _data);
      return formData;
    } else {
      return _body;
    }
  }

  Future<void> _cacheCustomKeys(Map<String, dynamic> result) async {
    for (final customKey in _customCacheKeys.entries) {
      final value = _getNestedValue(result, customKey.value);
      if (value != null) {
        await Cache.put(customKey.key, value);
      }
    }
  }

  dynamic _getNestedValue(Map<String, dynamic> map, String key) {
    final keys = key.split('.');
    dynamic value = map;
    for (final k in keys) {
      if (value is Map<String, dynamic> && value.containsKey(k)) {
        value = value[k];
      } else {
        return null;
      }
    }
    return value;
  }

  Future<FormData> _createFormData({
    required Map<String, File> files,
    Map<String, dynamic>? data,
  }) async {
    final formData = FormData();

    for (final entry in files.entries) {
      final fieldName = entry.key;
      final file = entry.value;
      formData.files.add(
        MapEntry(
          fieldName,
          await MultipartFile.fromFile(file.path),
        ),
      );
    }
    if (data != null) {
      for (final entry in data.entries) {
        final fieldName = entry.key;
        final value = entry.value;
        formData.fields.add(
          MapEntry(
            fieldName,
            value.toString(),
          ),
        );
      }
    }
    return formData;
  }
}
