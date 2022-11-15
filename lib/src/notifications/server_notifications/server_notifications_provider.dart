import '../core/notification_provider.dart';
import 'server_notification_data.dart';
import 'server_notification_model.dart';

mixin ServerNotificationsProvider on NotificationProvider {
  Stream<ServerNotificationData> get notifications;

  Stream<int> get unreadNotificationsCount;

  void load();

  void read(ServerNotificationModel notification);

  void readAll();

  void onTap(ServerNotificationModel notification);
}
