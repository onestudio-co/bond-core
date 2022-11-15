import 'dart:async';

import 'package:one_studio_core/src/network/models.dart';
import 'package:one_studio_core/src/notifications/notifications_core.dart';
import 'package:one_studio_core/src/notifications/push_notifications.dart';
import 'package:one_studio_core/src/notifications/server_notifications.dart';

class NotificationCenterProvider extends NotificationProvider
    with ServerNotificationsProvider, ActionableNotification {
  final PushNotificationProvider pushNotificationProvider;
  final NotificationCenterDataSource notificationCenterDataSource;

  NotificationCenterProvider({
    required this.pushNotificationProvider,
    required this.notificationCenterDataSource,
  });

  final serverNotificationStreamController =
      StreamController<ServerNotificationData>.broadcast();

  @override
  Stream<int> get unreadNotificationsCount =>
      serverNotificationStreamController.stream.map(
        (event) =>
            event.data.data.where((element) => element.readAt == null).length,
      );

  @override
  Stream<ServerNotificationData> get notifications =>
      serverNotificationStreamController.stream;

  ListResponse<ServerNotificationModel>? currentServerNotifications;

  @override
  void load() async {
    if (currentServerNotifications != null) {
      _loadNextPage(currentServerNotifications!);
    } else {
      _load();
    }
  }

  @override
  void read(ServerNotificationModel notification) async {
    if (currentServerNotifications == null) return;
    await notificationCenterDataSource.read(notification.uuid);
    final oldResponse = currentServerNotifications!;
    final newData = oldResponse.data
        .map(
          (element) => element.uuid == notification.uuid
              ? element.copyWith(readAt: DateTime.now())
              : element,
        )
        .toList();
    final newResponse = oldResponse.copyWith(data: newData);
    serverNotificationStreamController.add(
      ServerNotificationData(
        type: SeverNotificationChangedType.loaded,
        data: newResponse,
      ),
    );
    currentServerNotifications = newResponse;
  }

  @override
  void readAll() async {
    if (currentServerNotifications == null) return;
    await notificationCenterDataSource.readAll();
    final oldResponse = currentServerNotifications!;
    final newData = oldResponse.data
        .map((element) => element.copyWith(readAt: DateTime.now()))
        .toList();
    final newResponse = oldResponse.copyWith(data: newData);
    serverNotificationStreamController.add(
      ServerNotificationData(
        type: SeverNotificationChangedType.loaded,
        data: newResponse,
      ),
    );
    currentServerNotifications = newResponse;
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
        type: SeverNotificationChangedType.loaded,
        data: notifications,
      ),
    );
  }

  @override
  Future<void> dispose() async {
    await _streamsSubscriptions?.cancel();
  }

  void _load() async {
    final newResponse = await notificationCenterDataSource.loadNotifications();
    serverNotificationStreamController.add(
      ServerNotificationData(
        type: SeverNotificationChangedType.loaded,
        data: newResponse,
      ),
    );
    currentServerNotifications = newResponse;
  }

  void _loadNextPage(
      ListResponse<ServerNotificationModel> serverNotifications) async {
    serverNotificationStreamController.add(
      ServerNotificationData(
        type: SeverNotificationChangedType.loadingNextPage,
        data: serverNotifications,
      ),
    );
    final newResponse = await notificationCenterDataSource.loadNotifications(
        nextUrl: serverNotifications.links?.next);
    final oldData = serverNotifications.data;
    final combinedData = oldData.followedBy(newResponse.data).toList();
    serverNotificationStreamController.add(
      ServerNotificationData(
        type: SeverNotificationChangedType.loaded,
        data: newResponse.copyWith(data: combinedData),
      ),
    );
    currentServerNotifications = newResponse;
  }
}
