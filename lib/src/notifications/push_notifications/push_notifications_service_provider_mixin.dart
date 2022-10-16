import 'dart:developer';

import 'package:one_studio_core/src/injection/service_provider.dart';

import '../core/notification_data.dart';
import 'actionable_push_notification.dart';
import 'push_notification.dart';

mixin PushNotificationServiceProviderMixin on ServiceProvider {
  List<PushNotification> get pushNotifications;

  void handlePushNotification(NotificationData data) {
    log('try to handlePushNotification: $data');
    final String? code = data['code'] ?? data['item_type'];
    for (final pushNotification in pushNotifications) {
      if (pushNotification.code == code) {
        pushNotification.onNotification(data);
      }
    }
  }

  void handlePushNotificationAction(NotificationData data) {
    log('try to handlePushNotificationAction: $data');
    final String? code = data['code'] ?? data['item_type'];
    final String? deepLink =
        data['deep_link'] ?? data['item_type_id'].toString();
    if (deepLink == null) return;
    final actionablePushNotifications =
        pushNotifications.whereType<ActionablePushNotification>();
    for (final pushNotification in actionablePushNotifications) {
      if (pushNotification.code == code) {
        pushNotification.onNotificationTapped(deepLink);
      }
    }
  }
}
