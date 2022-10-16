import 'dart:async';
import 'dart:developer';

import 'package:one_studio_core/src/injection.dart';

import '../notifications_core.dart';
import '../push_notifications.dart';

class PushNotificationsProviders extends NotificationProvider
    with ActionableNotification {
  final List<PushNotificationProvider> pushNotificationProviders;

  PushNotificationsProviders({required this.pushNotificationProviders});

  final List<StreamSubscription<NotificationData>>
      _onNotificationsStreamsSubscriptions = [];
  final List<StreamSubscription<NotificationData>>
      _onNotificationsTappedStreamsSubscriptions = [];

  @override
  void listen() {
    for (final pushNotificationProvider in pushNotificationProviders) {
      final onPushNotificationStreamSubscription =
          pushNotificationProvider.onPushNotification.listen(onNotification);
      _onNotificationsStreamsSubscriptions
          .add(onPushNotificationStreamSubscription);
    }

    for (final pushNotificationProvider in pushNotificationProviders) {
      final onPushNotificationTappedStreamSubscription =
          pushNotificationProvider.onPushNotificationTapped
              .listen(onNotificationTapped);
      _onNotificationsTappedStreamsSubscriptions
          .add(onPushNotificationTappedStreamSubscription);
    }
  }

  @override
  void onNotification(Map<String, dynamic> data) {
    log('onNotification: $data');
    final featureProviders =
        providers.whereType<PushNotificationServiceProviderMixin>();
    for (final featureProvider in featureProviders) {
      featureProvider.handlePushNotification(data);
    }
  }

  @override
  Future<void> dispose() async {
    for (final streamSubscription in _onNotificationsStreamsSubscriptions) {
      await streamSubscription.cancel();
    }

    for (final streamSubscription
        in _onNotificationsTappedStreamsSubscriptions) {
      await streamSubscription.cancel();
    }
  }
}
