import 'package:bond_core/src/notifications/push_notifications/push_notification_provider_commons.dart';

abstract class PushNotificationProvider with NotificationProviderCommons {
  Future<String?> get token;

  Future<String?> get apnsToken;

  Stream<String> get onTokenRefresh;

  Future<void> deleteToken();
}
