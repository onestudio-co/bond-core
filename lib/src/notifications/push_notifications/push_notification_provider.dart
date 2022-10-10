import '../core/notification_data.dart';

abstract class PushNotificationProvider {
  void requestPermission();

  Future<String?> get token;

  Future<String?> get apnsToken;

  Stream<String> get onTokenRefresh;

  Stream<NotificationData> get onPushNotification;

  Stream<NotificationData> get onPushNotificationTapped;

  Future<NotificationData?> get initialNotification;

  Future<void> deleteToken();
}
