import '../core/notification_data.dart';

abstract class PushNotification {
  List<String> get code;

  void onNotification(NotificationData data);
}
