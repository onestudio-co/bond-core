import 'package:flutter/foundation.dart';

import 'analytics_event.dart';
import 'system_events.dart';

abstract class AnalyticsProvider {
  @mustCallSuper
  void log(AnalyticsEvent event) {
    try {
      _log(event);
    } on UnimplementedError catch (_) {
      logEvent(event);
    }
  }

  void _log(AnalyticsEvent event) {
    switch (event.systemEventType) {
      case SystemEvents.beginTutorial:
        logBeginTutorial();
        break;
      case SystemEvents.completeTutorial:
        logCompleteTutorial();
        break;
      case SystemEvents.signedUp:
        logSignedUp(event as UserSignedUp);
        break;
      case SystemEvents.signedIn:
        logSignedIn(event as UserSignedIn);
        break;
      case SystemEvents.signedOut:
        logSignedOut(event as UserSignedOut);
        break;
      case SystemEvents.updateProfile:
        updateProfile(event as UserUpdateProfile);
        break;
      case SystemEvents.viewItemList:
        logViewItemList(event as UserViewedItemList);
        break;
      case SystemEvents.viewItem:
        logViewItem(event as UserViewItem);
        break;
      case SystemEvents.selectItem:
        logSelectItem(event as UserSelectItem);
        break;
      case SystemEvents.viewPromotion:
        logViewPromotion(event as UserViewPromotion);
        break;
      case SystemEvents.selectPromotion:
        logSelectPromotion(event as UserSelectPromotion);
        break;
      case SystemEvents.addToCart:
        logAddToCart(event as UserAddedToCart);
        break;
      case SystemEvents.removeFromCart:
        logRemoveFromCart(event as UserRemovedFromCart);
        break;
      case SystemEvents.beginCheckout:
        logBeginCheckout(event as UserBeginCheckout);
        break;
      case SystemEvents.madePurchase:
        logMadePurchase(event as UserMadePurchase);
        break;
      case SystemEvents.refundOrder:
        logRefundOrder(event as UserRefundOrder);
        break;
      case SystemEvents.shareContent:
        logShareContent(event as UserShareContent);
        break;
      case SystemEvents.unknown:
        logEvent(event);
        break;
    }
  }

  void logEvent(AnalyticsEvent event);

  void setUserId(int userId);

  void setCurrentScreen(String screenName) {}

  void logBeginTutorial() {}

  void logCompleteTutorial() {}

  void logSignedUp(UserSignedUp event) {}

  void logSignedIn(UserSignedIn event) {}

  void logSignedOut(UserSignedOut event) {}

  void updateProfile(UserUpdateProfile event) {}

  void logViewItemList(UserViewedItemList event) {}

  void logViewItem(UserViewItem event) {}

  void logSelectItem(UserSelectItem event) {}

  void logViewPromotion(UserViewPromotion event) {}

  void logSelectPromotion(UserSelectPromotion event) {}

  void logAddToCart(UserAddedToCart event) {}

  void logRemoveFromCart(UserRemovedFromCart event) {}

  void logBeginCheckout(UserBeginCheckout event) {}

  void logMadePurchase(UserMadePurchase event) {}

  void logRefundOrder(UserRefundOrder event) {}

  void logShareContent(UserShareContent event) {}
}
