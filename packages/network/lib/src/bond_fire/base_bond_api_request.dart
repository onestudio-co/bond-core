import 'dart:convert';
import 'dart:io';

import 'package:bond_cache/bond_cache.dart';
import 'package:bond_core/bond_core.dart';
import 'package:dio/dio.dart';

part 'cache_policy.dart';
part 'get_bond_api_request.dart';

/// A factory function used to convert JSON data to a model of type [T].
typedef Factory<T> = T Function(Map<String, dynamic>);

/// A factory function used to convert JSON error response to a custom [Error].
typedef ErrorFactory<T extends Error> = T Function(Map<String, dynamic>);

/// Represents a base class for configuring and executing HTTP requests using Dio
/// with additional features such as custom header, body, files, cache and error handling.
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
  String? _cacheStore;

  BaseBondApiRequest(
    this._dio,
    String path, {
    required String method,
  })  : _path = path,
        _method = method;

  /// Adds custom headers to the request.
  ///
  /// Parameters:
  /// - [headers]: A map of headers to be added to the request.
  ///
  /// Returns: The current [BaseBondApiRequest] instance for chaining.
  BaseBondApiRequest<T> header(Map<String, String> headers) {
    _headers = headers;
    return this;
  }

  /// Adds query parameters to the request.
  ///
  /// -Parameters:
  ///  - [queryParameters]: A map of query parameters to be added to the request.
  ///
  /// Returns: The current [BaseBondApiRequest] instance for chaining.
  BaseBondApiRequest<T> queryParameters(Map<String, dynamic> queryParameters) {
    _queryParameters = queryParameters;
    return this;
  }

  /// Sets a JSON body for the request.
  ///
  /// -Parameters:
  /// - [body]: A map representing the JSON body to be sent with the request.
  ///
  ///  Returns: The current [BaseBondApiRequest] instance for chaining.
  BaseBondApiRequest<T> body(Map<String, dynamic> body) {
    _body = body;
    return this;
  }

  /// Attaches files to the request using a multipart form.
  ///
  /// -Parameters:
  /// - [files]: A map of file paths to be attached to the request.
  ///
  /// Returns: The current [BaseBondApiRequest] instance for chaining.
  BaseBondApiRequest<T> files(Map<String, File> files) {
    _files = files;
    return this;
  }

  /// Sets form-data to be included alongside files in the request.
  ///
  /// -Parameters:
  /// - [data]: A map representing the form-data to be sent with the request.
  ///
  /// Returns: The current [BaseBondApiRequest] instance for chaining.
  BaseBondApiRequest<T> data(Map<String, dynamic> data) {
    _data = data;
    return this;
  }

  /// Adds a cancel token to the request.
  ///
  /// -Parameters:
  /// - [cancelToken]: A [CancelToken] instance used to cancel the request.
  ///
  /// Returns: The current [BaseBondApiRequest] instance for chaining.
  BaseBondApiRequest<T> cancelToken(CancelToken cancelToken) {
    _cancelToken = cancelToken;
    return this;
  }

  /// Sets a factory function to convert the response body to a model of type [T].
  ///
  /// -Parameters:
  /// - [factory]: A function that takes a JSON map and returns an instance of type [T].
  ///
  /// Returns: The current [BaseBondApiRequest] instance for chaining.
  BaseBondApiRequest<T> factory(Factory<T> factory) {
    _factory = factory;
    return this;
  }

  /// Sets an error factory to convert failed responses into custom [Error]s.
  ///
  /// -Parameters:
  /// - [errorFactory]: A function that takes a JSON map and returns an instance of type [Error].
  ///
  /// Returns: The current [BaseBondApiRequest] instance for chaining.
  BaseBondApiRequest<T> errorFactory(ErrorFactory errorFactory) {
    _errorFactory = errorFactory;
    return this;
  }

  /// Enables caching a specific field from the response into a custom key.
  /// Optionally specify a different cache store.
  ///
  /// -Parameters:
  /// - [key]: The custom key under which the field will be cached.
  /// - [path]: The path to the field in the response data.
  /// - [store]: An optional custom cache store.
  ///
  /// Returns: The current [BaseBondApiRequest] instance for chaining.
  BaseBondApiRequest<T> cacheCustomKey(
    String key, {
    required String path,
    String? store,
  }) {
    _customCacheKeys[key] = path;
    _cacheStore = store;
    return this;
  }

  /// Executes the request and returns the processed result.
  ///
  /// - Returns: A [Future] that resolves to the response of type [T].
  Future<T> execute() async {
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
        for (final provider in appProviders.whereType<ResponseDecoding>()) {
          final model = provider.responseConvert<T>(response.data);
          if (model != null) {
            return model;
          }
        }
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

  /// Prepares data for the request body.
  Future<dynamic> _getRequestData() async {
    if (_files != null && _files!.isNotEmpty) {
      return await _createFormData(files: _files!, data: _data);
    } else {
      return _body;
    }
  }

  /// Caches specified fields from the response into local storage.
  Future<void> _cacheCustomKeys(Map<String, dynamic> result) async {
    for (final customKey in _customCacheKeys.entries) {
      final value = _getNestedValue(result, customKey.value);
      if (value != null) {
        if (_cacheStore != null) {
          await Cache.store(_cacheStore!).put(customKey.key, value);
        } else {
          await Cache.put(customKey.key, value);
        }
      }
    }
  }

  /// Extracts a nested field value from a map based on a dot-separated path.
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

  /// Creates a FormData instance for uploading files and data.
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
