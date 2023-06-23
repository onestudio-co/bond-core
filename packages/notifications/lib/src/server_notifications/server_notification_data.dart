import 'package:bond_network/network.dart';

import '../server_notifications.dart';

class ServerNotificationData {
  final SeverNotificationChangedType type;
  final ListResponse<ServerNotificationModel> data;

  ServerNotificationData({
    required this.type,
    required this.data,
  });
}
