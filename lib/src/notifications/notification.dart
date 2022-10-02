import 'notification_provider.dart';

abstract class Notification {
  List<NotificationProvider> get providers;

  String get code;
}
