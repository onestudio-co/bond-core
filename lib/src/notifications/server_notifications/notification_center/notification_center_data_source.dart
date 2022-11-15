import 'package:one_studio_core/core.dart';

abstract class NotificationCenterDataSource extends DataSource {
  Future<ListResponse<ServerNotificationModel>> loadNotifications();

  Future<void> read(String uuid);

  Future<void> readAll();
}
