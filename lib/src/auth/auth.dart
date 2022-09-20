import '../injection/injection_container.dart';
import 'auth_store.dart';
import 'authenticable.dart';

class Auth {
  static bool check() => sl<AuthStore>().hasToken;

  static Authenticable? user() => sl<AuthStore>().user;

  static bool get isVerify => sl<AuthStore>().user?.verificationAt != null;
}
