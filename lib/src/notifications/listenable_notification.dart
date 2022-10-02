import 'dart:async';

import 'package:flutter/foundation.dart';

import 'notification.dart';
import 'notification_provider.dart';

mixin ListenableNotification on Notification {
  final List<StreamSubscription<NotificationData>> streamsSubscriptions = [];

  @mustCallSuper
  void listen() {
    for (final provider in providers) {
      final streamSubscription = provider.onNotification.listen(onMessage);
      streamsSubscriptions.add(streamSubscription);
    }
  }

  @mustCallSuper
  void dispose() {
    for (final streamSubscription in streamsSubscriptions) {
      streamSubscription.cancel();
    }
  }

  void onMessage(NotificationData data);
}
