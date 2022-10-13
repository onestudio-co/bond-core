import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]);

  @override
  List<Object> get props => [];

  String toMessage();
}

class CacheFailure extends Failure{
  const CacheFailure({required this.error});
  final Map<String, dynamic> error;
  @override
  String toMessage() => error["message"] ?? '-';

}

class ServerFailure extends Failure {
  const ServerFailure({required this.error, required this.code});

  final Map<String, dynamic> error;
  final int code;

  Map<String, dynamic> get errors => error['errors'];

  String? getErrors(String key) {
    return errors[key] != null
        ? (errors[key] as List<dynamic>).join(',')
        : null;
  }

  @override
  String toMessage() => error["message"] ?? "-";
}

class ConnectionFailure extends Failure {
  @override
  String toMessage() => 'Check you internet connection';
}

