import 'package:dio/dio.dart';
import 'package:one_studio_core/src/cache.dart';

part 'get_bond_api_request.dart';

part 'cache_policy.dart';

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
  Map<String, dynamic> _body = <String, dynamic>{};
  Factory<T>? _factory;
  ErrorFactory? _errorFactory;

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

  BaseBondApiRequest<T> factory(Factory<T> factory) {
    _factory = factory;
    return this;
  }

  BaseBondApiRequest<T> errorFactory(ErrorFactory errorFactory) {
    _errorFactory = errorFactory;
    return this;
  }

  Future<T> execute() async {
    // Perform the request using _dio and handle the response
    // Convert the response JSON to the desired model using the provided factory method, error handler, etc.
    try {
      final response = await _dio.request(
        _path,
        queryParameters: _queryParameters,
        data: _body,
        options: Options(
          method: _method,
          headers: _headers,
        ),
      );
      if (_factory != null) {
        return _factory!(response.data);
      } else {
        return response.data;
      }
    } on DioError catch (error) {
      if (_errorFactory != null && error.response != null) {
        throw _errorFactory!(error.response!.data);
      }
      rethrow;
    } catch (error) {
      rethrow;
    }
  }
}
