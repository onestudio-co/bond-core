import 'notification_provider.dart';

abstract class AppNotification {
  List<NotificationProvider> get providers;

  String get code;
}
