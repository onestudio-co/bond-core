import 'package:get_it/get_it.dart';

import '../notifications.dart' show NotificationProvider;

abstract class ServiceProvider {
  Future<void> register(GetIt it);

  T? responseConvert<T>(Map<String, dynamic> json) => null;

  void registerNotifications(List<NotificationProvider> providers) {}
}
