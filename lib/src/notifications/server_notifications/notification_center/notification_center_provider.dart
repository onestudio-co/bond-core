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
        (event) =>
            event.data.data.where((element) => element.readAt == null).length,
      );

  @override
  Stream<ServerNotificationData> get notifications =>
      serverNotificationStreamController.stream;

  @override
  void load({String? nextUrl}) async {
    final newResponse =
        await notificationCenterDataSource.loadNotifications(nextUrl: nextUrl);
    if (nextUrl != null) {
      final serverNotificationData = await notifications.single;
      final response = serverNotificationData.data;
      final data = response.data.followedBy(newResponse.data).toList();
      serverNotificationStreamController.add(
        ServerNotificationData(
          type: SeverNotificationChangedType.load,
          data: response.copyWith(
            data: data,
            links: newResponse.links,
            meta: newResponse.meta,
          ),
        ),
      );
    } else {
      serverNotificationStreamController.add(
        ServerNotificationData(
          type: SeverNotificationChangedType.load,
          data: newResponse,
        ),
      );
    }
  }

  @override
  void read(ServerNotificationModel notification) async {
    await notificationCenterDataSource.read(notification.uuid);
    final serverNotificationData = await notifications.single;
    final response = serverNotificationData.data;
    final data = response.data
        .map(
          (element) => element.uuid == notification.uuid
              ? element.copyWith(readAt: DateTime.now())
              : element,
        )
        .toList();
    serverNotificationStreamController.add(
      ServerNotificationData(
        type: SeverNotificationChangedType.read,
        data: response.copyWith(data: data),
      ),
    );
  }

  @override
  void readAll() async {
    await notificationCenterDataSource.readAll();
    final serverNotificationData = await notifications.single;
    final response = serverNotificationData.data;
    final data = response.data
        .map((element) => element.copyWith(readAt: DateTime.now()))
        .toList();
    serverNotificationStreamController.add(
      ServerNotificationData(
        type: SeverNotificationChangedType.readAll,
        data: response.copyWith(data: data),
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
