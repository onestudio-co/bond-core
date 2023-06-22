import 'push_notification_provider_commons.dart';

abstract class PushNotificationProvider with PushNotificationProviderCommons {
  Future<String?> get token;

  Future<String?> get apnsToken;

  Stream<String> get onTokenRefresh;

  Future<void> deleteToken();
}
