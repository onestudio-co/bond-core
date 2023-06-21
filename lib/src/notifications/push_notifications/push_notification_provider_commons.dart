import 'package:bond_core/core.dart';

mixin NotificationProviderCommons {
  Stream<NotificationData> get onPushNotification;

  Stream<NotificationData> get onPushNotificationTapped;

  Future<NotificationData?> get initialNotification;
}
