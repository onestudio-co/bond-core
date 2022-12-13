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
      case SystemEvents.search:
        logSearch(event as UserSearch);
        break;
      case SystemEvents.viewSearchResults:
        logViewSearchResults(event as UserViewSearchResult);
        break;
      case SystemEvents.unknown:
        logEvent(event);
        break;
    }
  }

  void logEvent(AnalyticsEvent event);

  void setUserId(int userId);

  void setCurrentScreen(String screenName) {
    throw UnimplementedError('Set current screen not implemented');
  }

  void logBeginTutorial() {
    throw UnimplementedError('Begin tutorial not implemented');
  }

  void logCompleteTutorial() {
    throw UnimplementedError('Complete tutorial not implemented');
  }

  void logSignedUp(UserSignedUp event) {
    throw UnimplementedError('Signed up not implemented');
  }

  void logSignedIn(UserSignedIn event) {
    throw UnimplementedError('Signed in not implemented');
  }

  void logSignedOut(UserSignedOut event) {
    throw UnimplementedError('Signed out not implemented');
  }

  void updateProfile(UserUpdateProfile event) {
    throw UnimplementedError('Update profile not implemented');
  }

  void logViewItemList(UserViewedItemList event) {
    throw UnimplementedError('View item list not implemented');
  }

  void logViewItem(UserViewItem event) {
    throw UnimplementedError('View item not implemented');
  }

  void logSelectItem(UserSelectItem event) {
    throw UnimplementedError('Select item not implemented');
  }

  void logViewPromotion(UserViewPromotion event) {
    throw UnimplementedError('View promotion not implemented');
  }

  void logSelectPromotion(UserSelectPromotion event) {
    throw UnimplementedError('Select promotion not implemented');
  }

  void logAddToCart(UserAddedToCart event) {
    throw UnimplementedError('Add to cart not implemented');
  }

  void logRemoveFromCart(UserRemovedFromCart event) {
    throw UnimplementedError('Remove from cart not implemented');
  }

  void logBeginCheckout(UserBeginCheckout event) {
    throw UnimplementedError('Begin checkout not implemented');
  }

  void logMadePurchase(UserMadePurchase event) {
    throw UnimplementedError('Made purchase not implemented');
  }

  void logRefundOrder(UserRefundOrder event) {
    throw UnimplementedError('Refund order not implemented');
  }

  void logShareContent(UserShareContent event) {
    throw UnimplementedError('Share not implemented');
  }

  void logSearch(UserSearch event) {
    throw UnimplementedError('Search not implemented');
  }

  void logViewSearchResults(UserViewSearchResult event) {
    throw UnimplementedError('View search results not implemented');
  }
}
