import 'package:bond_core/core.dart';

mixin NotificationProviderCommons {
  Stream<NotificationData> get onNotification;

  Stream<NotificationData> get onNotificationTapped;

  Stream<NotificationData> get onNotificationDismiss;

  Future<NotificationData?> get initialNotification;
}
