import 'dart:convert';

import 'package:one_studio_core/src/auth/authenticable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthStore<User extends Authenticable> {
  final SharedPreferences sharedPreferences;
  final User Function(Map<String, dynamic>) fromJson;
  final Map<String, dynamic> Function(User) toJson;
  static var cachedToken = 'TOKEN';
  static const cachedUser = 'USER';

  AuthStore(this.sharedPreferences, this.fromJson, this.toJson);

  bool get hasToken => token != null;

  User? get user {
    final userString = sharedPreferences.getString(cachedUser);
    if (userString != null) {
      final user = fromJson(json.decode(userString));
      return user;
    }
    return null;
  }

  set user(User? user) {
    if (user != null) {
      sharedPreferences.setString(cachedUser, json.encode(toJson(user)));
    }
  }

  String? get token => sharedPreferences.getString(cachedToken);

  set token(String? token) {
    if (token != null) {
      sharedPreferences.setString(AuthStore.cachedToken, token);
    }
  }

  Future<void> clearAppData([List<String>? expect]) async {
    for (final key in sharedPreferences.getKeys()) {
      if (expect != null && expect.contains(key)) {
        continue;
      }
      await sharedPreferences.remove(key);
    }
    await sharedPreferences.reload();
  }
}
