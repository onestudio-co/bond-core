abstract class AnalyticsEvent {
  String? get key => null;

  Map<String, dynamic> get params => {};

  SystemEvents get systemEventType => SystemEvents.unknown;
}

enum SystemEvents {
  beginTutorial,
  completeTutorial,
  signedUp,
  signedIn,
  signedOut,
  updateProfile,
  viewItemList,
  viewItem,
  selectItem,
  viewPromotion,
  selectPromotion,
  addToCart,
  removeFromCart,
  beginCheckout,
  madePurchase,
  refundOrder,
  shareContent,
  unknown,
}
