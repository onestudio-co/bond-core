import 'server_notification_model.dart';

class ServerNotificationData {
  final SeverNotificationChangedType type;
  final List<ServerNotificationModel> data;

  ServerNotificationData({
    required this.type,
    required this.data,
  });
}
