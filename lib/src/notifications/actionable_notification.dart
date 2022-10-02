import 'dart:async';

import 'package:flutter/foundation.dart';

import 'app_notification.dart';
import 'notification_provider.dart';

mixin ActionableNotification on AppNotification {
  final List<StreamSubscription<NotificationData>> streamsSubscriptions = [];

  @mustCallSuper
  void listen() {
    for (final provider in providers) {
      final streamSubscription =
      provider.onNotificationTapped.listen(onNotificationTapped);
      streamsSubscriptions.add(streamSubscription);
    }
  }

  @mustCallSuper
  void dispose() {
    for (final streamSubscription in streamsSubscriptions) {
      streamSubscription.cancel();
    }
  }

  void onNotificationTapped(NotificationData data);
}

