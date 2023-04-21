import 'package:dio/dio.dart';
import 'package:one_studio_core/src/injection.dart';

import 'base_bond_api_request.dart';

/// BondApiClient is a simple API client built on top of Dio.
class BondFire {
  static final BondFire _instance = BondFire._();

  factory BondFire() => _instance;

  final Dio _dio;

  BondFire._() : _dio = sl<Dio>();

  GetBondApiRequest<T> get<T>(String path) => GetBondApiRequest<T>(_dio, path);

  BaseBondApiRequest<T> post<T>(String path) =>
      BaseBondApiRequest<T>(_dio, path, method: 'POST');

  BaseBondApiRequest<T> put<T>(String path) =>
      BaseBondApiRequest<T>(_dio, path, method: 'PUT');

  BaseBondApiRequest<T> delete<T>(String path) =>
      BaseBondApiRequest<T>(_dio, path, method: 'DELETE');
}
