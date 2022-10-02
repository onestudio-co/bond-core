import 'notification_provider.dart';

abstract class Notification {
  List<NotificationProvider> providers = [];

  String get code;
}
