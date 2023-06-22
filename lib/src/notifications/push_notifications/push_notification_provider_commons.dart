import '../core/notification_data.dart';

mixin PushNotificationProviderCommons {
  Stream<NotificationData> get onPushNotification;

  Stream<NotificationData> get onPushNotificationTapped;

  Future<NotificationData?> get initialNotification;
}
