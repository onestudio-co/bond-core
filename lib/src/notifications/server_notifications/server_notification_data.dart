
import 'package:bond_core_temp/src/network.dart';

import '../server_notifications.dart';

class ServerNotificationData {
  final SeverNotificationChangedType type;
  final ListResponse<ServerNotificationModel> data;

  ServerNotificationData({
    required this.type,
    required this.data,
  });
}
