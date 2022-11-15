import 'dart:async';

import 'package:one_studio_core/src/notifications/notifications_core.dart';
import 'package:one_studio_core/src/notifications/push_notifications.dart';

import '../../server_notifications.dart';
import '../server_notification_data.dart';

class NotificationCenterProvider extends NotificationProvider
    with ServerNotificationsProvider, ActionableNotification {
  final PushNotificationProvider pushNotificationProvider;
  final NotificationCenterDataSource notificationCenterDataSource;

  NotificationCenterProvider({
    required this.pushNotificationProvider,
    required this.notificationCenterDataSource,
  });

  final serverNotificationStreamController =
      StreamController<ServerNotificationData>();

  @override
  Stream<int> get unreadNotificationsCount =>
      serverNotificationStreamController.stream.map(
        (event) => event.data.where((element) => element.readAt == null).length,
      );

  @override
  Stream<ServerNotificationData> get notifications =>
      serverNotificationStreamController.stream;

  @override
  void read(ServerNotificationModel notification) async {
    final notifications = await notificationCenterDataSource.read(notification);
    serverNotificationStreamController.add(
      ServerNotificationData(
        type: SeverNotificationChangedType.read,
        data: [notifications],
      ),
    );
  }

  @override
  void readAll() async {
    await notificationCenterDataSource.readAll();
    serverNotificationStreamController.add(
      ServerNotificationData(
        type: SeverNotificationChangedType.readAll,
        data: [],
      ),
    );
  }

  @override
  void onTap(ServerNotificationModel notification) =>
      onNotificationTapped(notification.data);

  StreamSubscription<NotificationData>? _streamsSubscriptions;

  @override
  void listen() {
    _streamsSubscriptions =
        pushNotificationProvider.onPushNotification.listen(onNotification);
  }

  @override
  void onNotification(Map<String, dynamic> data) async {
    final notifications =
        await notificationCenterDataSource.loadNotifications();
    serverNotificationStreamController.add(
      ServerNotificationData(
        type: SeverNotificationChangedType.load,
        data: notifications,
      ),
    );
  }

  @override
  Future<void> dispose() async {
    await _streamsSubscriptions?.cancel();
  }
}
