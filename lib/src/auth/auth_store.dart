import 'package:one_studio_core/src/auth/authenticable.dart';

abstract class AuthStore<T extends Authenticable> {
  bool get hasToken => false;

  T? get user => null;

  set user(T? user);

  String? get token => null;

  set token(String? token);

  Future<void> clearAppData();
}
