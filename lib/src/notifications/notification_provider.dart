typedef NotificationData = Map<String, dynamic>;

abstract class NotificationProvider {
  Future<String?> get token;

  Future<String?> get apnsToken;

  Stream<String> get onTokenRefresh;

  Stream<NotificationData> get onNotification;

  Stream<NotificationData> get onNotificationTapped;

  Future<NotificationData?> get initialMessage;

  Future<void> deleteToken();
}
