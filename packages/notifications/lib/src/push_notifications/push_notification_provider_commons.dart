import '../core/notification_data.dart';

mixin PushNotificationProviderCommons {
  Stream<NotificationData> get onNotification;

  Stream<NotificationData> get onNotificationTapped;

  Stream<NotificationData> get onNotificationDismiss;

  Future<NotificationData?> get initialNotification;
}
