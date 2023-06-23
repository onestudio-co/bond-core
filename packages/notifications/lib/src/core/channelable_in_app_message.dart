mixin ChannelableInAppMessage {
  Future<void> suspendInAppNotifications();

  Future<void> discardInAppNotifications();

  Future<void> resumeInAppNotifications();
}
