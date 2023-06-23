import 'dart:async';

abstract class NotificationProvider {
  void listen();

  void onNotification(Map<String, dynamic> data);

  Future<void> dispose();
}
