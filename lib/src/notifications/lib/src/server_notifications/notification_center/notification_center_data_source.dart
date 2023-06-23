import 'package:bond_network/network.dart';
import 'package:bond_notifications/notifications.dart';

abstract class NotificationCenterDataSource extends DataSource {
  Future<ListResponse<ServerNotificationModel>> loadNotifications(
      {String? nextUrl});

  Future<void> read(String uuid);

  Future<void> readAll();
}
