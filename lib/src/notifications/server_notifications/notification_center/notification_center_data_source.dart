import 'package:bond_core/core.dart';

abstract class NotificationCenterDataSource extends DataSource {
  Future<ListResponse<ServerNotificationModel>> loadNotifications({String? nextUrl});

  Future<void> read(String uuid);

  Future<void> readAll();
}
