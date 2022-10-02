import 'package:one_studio_core/src/injection/service_provider.dart';
import 'package:one_studio_core/src/notifications.dart';

mixin NotificationServiceProvider on ServiceProvider {
  List<AppNotification> get notifications;

  void registerNotifications() {
    for (final notification in notifications) {
      if (notification is ListenableNotification) {
        notification.listen();
      }
      if (notification is ActionableNotification) {
        notification.listen();
      }
    }
  }

  void unregisterNotifications() {
    for (final notification in notifications) {
      if (notification is ListenableNotification) {
        notification.dispose();
      }
      if (notification is ActionableNotification) {
        notification.dispose();
      }
    }
  }
}
