import 'package:one_studio_core/src/injection.dart';

import '../notifications_core.dart';
import 'push_notification.dart';
import 'push_notifications_service_provider_mixin.dart';

mixin ActionablePushNotification on PushNotification {
  void onNotificationTapped(NotificationData data);
}

mixin ActionableNotification on NotificationProvider {
  void onNotificationTapped(NotificationData data) {
    final featureProviders =
        providers.whereType<PushNotificationServiceProviderMixin>();
    for (final featureProvider in featureProviders) {
      featureProvider.handlePushNotificationAction(data);
    }
  }
}
