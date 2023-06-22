import 'package:bond_core/src/core/core.dart';

abstract class NotificationCenterDataSource extends DataSource {
  Future<ListResponse<ServerNotificationModel>> loadNotifications({String? nextUrl});

  Future<void> read(String uuid);

  Future<void> readAll();
}
