import '../core/notification_data.dart';

abstract class PushNotification {
  String get code;

  void onNotification(NotificationData data);
}
