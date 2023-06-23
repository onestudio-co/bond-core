import 'package:bond_network/network.dart';
import '../../../notifications.dart';

abstract class NotificationCenterDataSource extends DataSource {
  Future<ListResponse<ServerNotificationModel>> loadNotifications(
      {String? nextUrl});

  Future<void> read(String uuid);

  Future<void> readAll();
}
