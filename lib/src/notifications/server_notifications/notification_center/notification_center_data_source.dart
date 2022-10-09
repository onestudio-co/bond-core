import '../server_notification_model.dart';

abstract class NotificationCenterDataSource {
  Future<List<ServerNotificationModel>> loadNotifications();

  Future<ServerNotificationModel> read(
      ServerNotificationModel serverNotificationModel);

  Future<void> readAll();
}
