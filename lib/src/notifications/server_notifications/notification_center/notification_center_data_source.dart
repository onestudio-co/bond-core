import 'package:bond_network/network.dart';
import 'package:bond_core_temp/src/notifications/server_notifications.dart';

abstract class NotificationCenterDataSource extends DataSource {
  Future<ListResponse<ServerNotificationModel>> loadNotifications(
      {String? nextUrl});

  Future<void> read(String uuid);

  Future<void> readAll();
}
