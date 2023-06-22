import 'dart:async';

import 'package:bond_core/src/core/core.dart';

class CleverTapPushNotificationProvider {

  // final CleverTapPlugin _cleverTapPlugin;

  final StreamController<NotificationData> _pushNotificationTappedController =
      StreamController<Map<String, dynamic>>.broadcast();

  // CleverTapPushNotificationProvider(this._cleverTapPlugin);

  Stream<NotificationData> get onPushNotification {
    // CleverTapPlugin.pushNotificationClickedEvent();
    return _pushNotificationTappedController.stream;
  }

  Stream<NotificationData> get onPushNotificationTapped {
    // _cleverTapPlugin.setCleverTapPushClickedPayloadReceivedHandler((
    //   Map<String, dynamic> payload,
    // ) {
    //   _pushNotificationTappedController.add(payload);
    // });
    return _pushNotificationTappedController.stream;
  }
}
