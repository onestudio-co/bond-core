mixin ChannelableNotification {
  Future<void> createNotificationChannel({
    required String channelId,
    required String channelName,
    required String channelDescription,
    required int importance, // TODO read from constant
    required bool showBadge,
    String? sound,
    String? groupId,
  });

  /// Method to delete Notification Channel
  Future<void> deleteNotificationChannel(String channelId);

  /// Method to create Notification Channel Group
  Future<void> createNotificationChannelGroup(String groupId, String groupName);

  /// Method to delete Notification Channel Group
  Future<void> deleteNotificationChannelGroup(String groupId);

  /// Method to create Notification using CleverTap
  Future<void> createNotification(dynamic data);
}
